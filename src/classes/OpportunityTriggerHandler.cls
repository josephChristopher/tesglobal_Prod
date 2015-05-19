public with sharing class OpportunityTriggerHandler extends Reach.TriggerHandlerFactory {
	
	public override void beforeInsert() {
		allocateOpportunity();
	}
	
	public override void afterUpdate() {
		updateAllocation();
		linkContactsToAccount();
	}
	
	private void allocateOpportunity() {
		User[] agencyUsers = [select Id,
                           RTF_Booking_Quota__c,
                           Current_Booking_Count__c
                    from User where (UserRole.Name = 'Customer Services Executive - Agency'
                          or UserRole.Name = 'Head of Customer Services - Agency'
                          or UserRole.Name = 'Customer Services Manager - Agency')
                          and Profile.Name != 'Temporary Booker'
                          and On_Leave__c = False and isactive = true
                    Order By Quota_Current_Diff__c DESC];
    User[] directUsers = [select Id,
                           RTF_Booking_Quota__c,
                           Current_Booking_Count__c
                    from User where (UserRole.Name = 'Head of Customer Services - Direct'
                          or UserRole.Name = 'Customer Services Executive - Direct'
                          or UserRole.Name = 'Customer Services Manager - Direct')
                          and Profile.Name != 'Temporary Booker'
                          and On_Leave__c = False and isactive = true
                    Order By Quota_Current_Diff__c DESC];
    Set<Id> allUserIds = new Set<Id>();
    for(User u : agencyUsers) {
        allUserIds.add(u.Id);
    }
    for(User u : directUsers) {
        allUserIds.add(u.Id);
    }
    Busy_Time_Log__c[] timeLog = [select User__c, Date__c, End_Time__c, Start_Time__c from Busy_Time_Log__c 
                                  where User__c in :allUserIds and (Date__c = :System.today() or Date__c = null)];
    for(Busy_Time_Log__c l : timeLog) {
        //only add the log if the current time is between the start and end times specified.
        String startTime = (String)l.Start_Time__c;
        String endTime = (String)l.End_Time__c;
        Datetime startDt = Datetime.newInstance(Date.today(), Time.newInstance(Integer.valueOf(startTime.substringBefore(':')),
                                                                          Integer.valueOf(startTime.substringAfter(':')), 
                                                                          0, 0));
        Datetime endDt = Datetime.newInstance(Date.today(), Time.newInstance(Integer.valueOf(endTime.substringBefore(':')),
                                                                          Integer.valueOf(endTime.substringAfter(':')), 
                                                                          59, 999));
        Datetime nowDt = Datetime.now();
        if(nowDt >= startDt && nowDt <= endDt) {
            //this means that we are in the time period in which the user should be excluded from allocation
            Integer idx = -1;
            Integer ctr = 0;
            for(User u : agencyUsers) {
                if(u.Id == l.User__c) {
                    idx = ctr;
                    break;
                }
                ctr++;
            }
            if(idx >= 0) {
                agencyUsers.remove(idx);
            } else {
                ctr = 0;
                for(User u : directUsers) {
                    if(u.Id == l.User__c) {
                        idx = ctr;
                        break;
                    }
                    ctr++;
                }
                if(idx >= 0) {
                    directUsers.remove(idx);
                }
            }
        }
    }
    
    
    Integer pos = 0;
    User usr = null;
    Opportunity[] oppList = Trigger.new;
    Set<Id> AccountIdList = new Set<Id>();
    Map<Id,Opportunity> ContactIdMap = new Map<Id,Opportunity>();
    Map<Id,Opportunity> FolderIdMap = new Map<Id,Opportunity>();
    for(Opportunity opp : oppList) {
        AccountIdList.add(opp.AccountId);
        if(opp.Order_By__c != null) {
        	ContactIdMap.put(opp.Order_By__c,opp);
        }
        if(opp.Mailbox__c != null) {
        	FolderIdMap.put(opp.Mailbox__c,opp);
        }
    }
    
    RecordType accountRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Account' AND Name = 'Account Edit Locked'];
    RecordType opportunityRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Opportunity' AND Name = 'SFDC Booking'];
    Contact[] contactList = [select Id,Last_Allocated_Sales_Rep__c,Last_Allocation_Date__c from Contact 
    								   where Id in :ContactIdMap.keySet()];
    Map<Id,Contact> contactMap = new Map<Id,Contact>();
    Map<Id,Contact> allocationContactMap = new Map<Id,Contact>();
    for(Contact c : contactList) {
    	if(c.Last_Allocation_Date__c != null && c.Last_Allocation_Date__c == Date.today()) {
    		contactMap.put(ContactIdMap.get(c.Id).Id,c);
    	} else {
    		allocationContactMap.put(ContactIdMap.get(c.Id).Id,c);
    	}
    }
    
    Account[] opportunityAccounts = [Select Id,RecordTypeId From Account where Id in :AccountIdList];
    Map<Id,Folder__c> opportunityFolders = new Map<Id,Folder__c>([Select Id,Allocation_Group__c From Folder__c where Id in :FolderIdMap.keySet()]);
    Map<Id,Contact> updatedContacts = new Map<Id,Contact>();
    for(Opportunity opp : oppList) {
    	//check if there is a pre-defined owner for this contact.
    	if(opp.Mailbox__c != null && opportunityFolders.get(opp.Mailbox__c) != null && opp.RecordTypeId == opportunityRecordType.Id) {
	    	Contact preDefinedContact = contactMap.get(opp.Order_By__c);
	    	if(preDefinedContact != null) {
	    		opp.OwnerId = preDefinedContact.Last_Allocated_Sales_Rep__c;
	    	} else {
	        User[] users = null;
	        Folder__c oppMailbox = opportunityFolders.get(opp.Mailbox__c);
	        if(oppMailbox.Allocation_Group__c != null && oppMailbox.Allocation_Group__c == 'DIRECT') {
	        	users = directUsers;
	        } else if(oppMailbox.Allocation_Group__c != null && oppMailbox.Allocation_Group__c == 'AGENCY') {
	        	users = agencyUsers;
	        }
	        if(users != null && users.size() > pos) {
	            usr = users[pos];
	            if(usr.RTF_Booking_Quota__c == null) {
	                usr.RTF_Booking_Quota__c = 10;
	            }
	            if(usr.Current_Booking_Count__c == null) {
	                usr.Current_Booking_Count__c = 0;
	            }
	            if((usr.RTF_Booking_Quota__c - usr.Current_Booking_Count__c) <= 0) {
	                //lets go ahead and find the next viable user.
	                Integer ctr = 0;
	                usr = null;
	                System.debug(LoggingLevel.INFO,'Current Position is: '+pos+' the number of users is: '+users.size());
	                for(User nUser : users) {
	                    if(ctr > pos) {
	                    	nUser.RTF_Booking_Quota__c = (nUser.RTF_Booking_Quota__c == null ? 10 : nUser.RTF_Booking_Quota__c);
	                    	nUser.Current_Booking_Count__c = (nUser.Current_Booking_Count__c == null ? 0 : nUser.Current_Booking_Count__c);
	                        if((nUser.RTF_Booking_Quota__c - nUser.Current_Booking_Count__c) > 0) {
	                             usr = nUser;
	                             pos = ctr;
	                             break;
	                        }
	                    }
	                    ctr++;
	                }
	                if(usr == null) {
	                    pos = 0;
	                    usr = users[pos];
	                }
	            }
	            opp.OwnerId = usr.Id;
	            usr.Current_Booking_Count__c = usr.Current_Booking_Count__c+1;
	            //we also want to set the contact for this booking to have all subsiquent bookings allocated to the same user.
	            Contact c = allocationContactMap.get(opp.Id);
	            if(c != null) {
		            c.Last_Allocated_Sales_Rep__c = usr.Id;
		            c.Last_Allocation_Date__c = Date.today();
		            updatedContacts.put(c.Id,c);
		            contactMap.put(c.Id,c);
	            }
	            pos++;
	            if(pos <= users.size()) {
	                pos = 0;
	            }
	            usr = users[pos];
	        }
	    	}
    	}
    }
   
    if(!updatedContacts.isEmpty()) {
    	update updatedContacts.values();
    }
    
    update agencyUsers;
    update directUsers;
	}
	
	private void updateAllocation() {
		Opportunity[] oppList = Trigger.New;
    Opportunity[] oldOppList = Trigger.Old;
    Set<Id> oppIdList = new Set<Id>();
    Map<Id,Opportunity> newOpportunityMap = new Map<Id,Opportunity>();
    for(Opportunity opp : oppList) {
        oppIdList.add(opp.OwnerId);
        newOpportunityMap.put(opp.Id,opp);
    }
    for(Opportunity opp : oldOppList) {
        Opportunity newOpp = newOpportunityMap.get(opp.Id);
        if(newOpp.OwnerId != opp.OwnerId) {
          oppIdList.add(opp.OwnerId);
        }
    }
    List<AggregateResult> userIdMap = [select OwnerId,count(Id) from Opportunity where (Email_Status__c = 'Unread' or Email_Status__c = 'Awaiting Booking')
                               and OwnerId in :oppIdList 
                               group by OwnerId];
    
    Set<Id> userIdList = new Set<Id>();
    Map<Id,Integer> userOppCounter = new Map<Id,Integer>();
    for(AggregateResult o : userIdMap) {
        userIdList.add((Id)o.get('OwnerId'));
        userOppCounter.put((Id)o.get('OwnerId'),(Integer)o.get('expr0'));
    }
    User[] userList = [select Id,Current_Booking_Count__c,RTF_Booking_Quota__c from User where Id in :userIdList];
    for(User u : userList) {
        Integer numOpps = userOppCounter.get(u.Id);
        if(numOpps > 0) {
            u.Current_Booking_Count__c = numOpps;
        }
    }
    update userList;
	}
	
	/**
	 * this method will ensure that if there are contacts tied to this opportunity
	 * which are not associated to an account they will be automatically associated to 
	 * the account which is linked to this opportunity provided an account is linked to the 
	 * opportunity
	 **/
	private void linkContactsToAccount() {
		Map<Id,Opportunity> oppMap = (Map<Id,Opportunity>)Trigger.newMap;
		List<Id> accountOppList = new List<Id>();
		for(Opportunity opp : oppMap.values()) {
			if(opp.AccountId != null) {
				accountOppList.add(opp.Id);
			}
		}
		if(!accountOppList.isEmpty()) {
			OpportunityContactRole[] contactRoles = [Select OpportunityId,ContactId from OpportunityContactRole where OpportunityId in :accountOppList];
			Map<Id,Id> contactOpportunityMap = new Map<Id,Id>();
			for(OpportunityContactRole contact : contactRoles) {
				contactOpportunityMap.put(contact.ContactId,contact.OpportunityId);
			}
			if(!contactOpportunityMap.isEmpty()) {
				Contact[] contactList = [select Id,AccountId from Contact where Id in :contactOpportunityMap.keySet() and AccountId = null for update];
				for(Contact c : contactList) {
					Opportunity opp = oppMap.get(contactOpportunityMap.get(c.Id));
					c.AccountId = opp.AccountId;
				}
				update contactList;
			}
		}
	}
}