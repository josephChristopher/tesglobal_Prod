trigger CaseAllocationTgr on Case (before insert) {
  
    /*User[] engagementExecs = [SELECT Id,
                            RTF_Booking_Quota__c,
                            Current_Booking_Count__c
                            FROM User WHERE UserRole.Name = 'Engagement Executive'
                            and Profile.Name = 'Engagement Executive'
                            and On_Leave__c = False
                            and IsActive = TRUE
                            ORDER BY Quota_Current_Diff__c DESC];
    
     
    Set<Id> allUserIds = new Set<Id>();
    
    for(User u : engagementExecs) {
        allUserIds.add(u.Id);
    }
    
    Busy_Time_Log__c[] timelog = [SELECT User__c, Date__c, End_Time__c, Start_Time__c from Busy_Time_Log__c
                                  WHERE User__c in :allUserIds and (Date__c = :System.today() or Date__c = null)];
    for (Busy_Time_Log__c l : timeLog) {
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
            
            for(User u : engagementExecs) {
                if(u.Id == l.User__c) {
                    idx = ctr;
                    break;
                }
                ctr++;
            }
            
            if(idx >= 0) {
                engagementExecs.remove(idx);
            }   
        }
    }
    
    Integer pos = 0;
    User usr = null;
    
    Case[] caseList = Trigger.new;
    
    RecordType cstCaseRT = [SELECT Id FROM RecordType WHERE Name = 'Customer Success Case - Surveys' LIMIT 1];
    RecordType mktShareCaseRT = [SELECT Id FROM RecordType WHERE Name = 'Market Share Case' LIMIT 1];
    User defaultOwner = [SELECT Id FROM User WHERE Name = 'Anthony Canning' LIMIT 1];
  
    for(Case cs : Trigger.New) {
        
        if(cs.RecordTypeId == mktShareCaseRT.Id) {
            
            User[] eUsers = engagementExecs;
            
            usr = eUsers[pos];
            
            if(usr.RTF_Booking_Quota__c == null) {
                usr.RTF_Booking_Quota__c = 10;
            }
            if(usr.Current_Booking_Count__c == null) {
                usr.Current_Booking_Count__c = 0;
            }
            
            if((usr.RTF_Booking_Quota__c - usr.Current_Booking_Count__c) <=0) {
                //find the next user.
                Integer ctr = 0;
                usr = null;
                for(User nUser : eUsers) {
                    if (ctr > pos) {
                        if(nUser.RTF_Booking_Quota__c == null) {
                            nUser.RTF_Booking_Quota__c = 10;
                        }
                        if(nUser.Current_Booking_Count__c == null) {
                            nUser.Current_Booking_Count__c = 0;
                        }
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
                    usr = eUsers[pos];
                }
            }
            
            cs.OwnerId = usr.Id;
            
            usr.Current_Booking_Count__c = usr.Current_Booking_Count__c+1;
            pos++;
            if(pos <= eUsers.size()) {
                pos = 0;
            }
            usr = eUsers[pos];
            
        } else if (cs.RecordTypeId == cstCaseRT.Id && cs.Status == 'Pre-Check In') {
            
             	cs.OwnerId = defaultOwner.Id;
        
        } 
    }

     update engagementExecs;*/
}