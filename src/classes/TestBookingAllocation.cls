@isTest
public class TestBookingAllocation {
    
    @isTest(SeeAllData=false)
    static void TestBookingAllocation(){
        
        User thisUser = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' and IsActive = true limit 1];
        
        System.runAs (thisUser) {
            RecordType TypeAccountLocked = [select Id from RecordType where Name = 'Account Edit Locked' and SobjectType = 'Account'];
            List<UserRole> roleList = [SELECT Id, Name FROM UserRole WHERE Name IN ('Customer Services Executive - Agency','Head of Customer Services - Agency','Customer Services Manager - Agency','Head of Customer Services - Direct','Customer Services Executive - Direct','Customer Services Manager - Direct')];
            UserRole roleAgency = [select Id from UserRole where name = 'Customer Services Executive - Agency'];
            UserRole roleDirect = [select Id from UserRole where name = 'Customer Services Executive - Direct'];
            RecordType SFDCBooking = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Opportunity' AND Name = 'SFDC Booking' LIMIT 1];
            
            List<Profile> profileList = [SELECT Id, Name FROM Profile WHERE Name IN ('Temporary Booker')];
            Profile tempBookerProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Temporary Booker'];
            Profile permanentBookerProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Permanent Booker'];
            //activate current users
            
            List<User> currentUsers = [SELECT Id, FirstName, Current_Booking_Count__c, RTF_Booking_Quota__c 
                                       FROM User 
                                       WHERE UserRoleId =: RoleList
                                       AND ProfileId !=: ProfileList and IsActive = True
                                       ];
            
            update currentUsers;
            
            //create busy time log
            if(currentUsers.size()>0)
            {
                Busy_Time_Log__c b = new Busy_Time_Log__c();
            
                b.Date__c = date.today();
                b.Start_Time__c = '00:00';
                b.End_Time__c = '23:45';
                b.User__c = currentUsers[0].Id;
                b.Reason_for_Unavailability__c = 'test';
                
                insert b;   
            }
           
            
            //insert new account
            Account directAcc = new Account(Name='Direct Test Account',
                                  Client_Type__c = 'To Be Analysed',
                                  Customer_Group__c = 'Academy',
                                  Street__c = '29 Darling',
                                  City_Town__c = 'Boston',
                                  Country__c = 'UGANDA',
                                  Post_Code__c = '312312',
                                  Phone = '123231231',
                                  Main_Email__c = 'dsadsa@dsadsa.com',
                                  Region_1__c = 'Classified',
                                  Region_2__c = 'United Kingdom',
                                  Not_Approved_by_Finance__c = false,
                                  RecordTypeId = TypeAccountLocked.Id);
                                  
            Account acc = new Account(Name='Test Account',
                                  Client_Type__c = 'To Be Analysed',
                                  Customer_Group__c = 'Academy',
                                  Street__c = '29 Darling',
                                  City_Town__c = 'Boston',
                                  Country__c = 'UGANDA',
                                  Post_Code__c = '312312',
                                  Phone = '123231231',
                                  Main_Email__c = 'dsadsa@dsadsa.com',
                                  Region_1__c = 'Classified',
                                  Region_2__c = 'United Kingdom',
                                  Not_Approved_by_Finance__c = false);
        
            insert new Account[] { acc, directAcc };
            //we should create a contact
            Contact c = new Contact(FirstName = 'Test',LastName = 'Assigned',Salutation = 'Mr',AccountId = acc.Id, Email = 'test@test01.com',Phone = '0000');
            Contact uc = new Contact(FirstName = 'Test',LastName = 'Without account',Salutation = 'Mr', Email = 'test@test02.com',Phone = '0000');
            insert new Contact[] { c, uc };
            
            //create a mailbox allocated to an agency
            Folder__c agencyFolder = new Folder__c(Name = 'Agency Folder',Allocation_Group__c = 'AGENCY',Email__c = 'agency@tesglobal.com');
            //create a mailbox allocated to a direct
            Folder__c directFolder = new Folder__c(Name = 'Direct Folder',Allocation_Group__c = 'DIRECT',Email__c = 'direct@tesglobal.com');
            insert new Folder__c[] {agencyFolder,directFolder};
            
            //insert new bookings
            Test.startTest();
            
            //add a basic not busy agency user and then try to allocate 2 opportunities.
            User notBusyAgencyUser01 = new User(firstname = 'Test',lastname = 'Agency Not Busy', email = 'testagency03@tesglobal.com',
	    				  username = 'testagency03@tesglobal.com', profileid=permanentBookerProfile.id, alias = 'tsgagy03', 
	    				  TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
	    				  LanguageLocaleKey = 'en_US', UserRoleId = roleAgency.Id, On_Leave__c = False, IsActive = true,
	    				  RTF_Booking_Quota__c = 2);
	    			insert notBusyAgencyUser01;
	    			
	    			List<Opportunity> oppList = new List<Opportunity>();
	    			for(Integer i = 0; i < 5; i++) {
	    				Opportunity opp2 = new Opportunity();
	            opp2.Name='Agency Booking' + i;
	            opp2.StageName='TBD';
	            opp2.CloseDate=Date.today();
	            opp2.RecordTypeId = SFDCBooking.Id;
	            opp2.Email_Status__c = 'Unread';
	            opp2.Agency__c = acc.Id;
	            opp2.Mailbox__c = agencyFolder.Id;
	            oppList.add(opp2);
	    			}
	    			insert oppList;
	    			
	    			notBusyAgencyUser01.IsActive = false;
	    			update notBusyAgencyUser01;
	    			
	        //add an agency user which is not busy.
	        User notBusyAgencyUser = new User(firstname = 'Test',lastname = 'Agency Not Busy', email = 'testagency01@tesglobal.com',
	    				  username = 'testagency01@tesglobal.com', profileid=permanentBookerProfile.id, alias = 'tsgagy01', 
	    				  TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
	    				  LanguageLocaleKey = 'en_US', UserRoleId = roleAgency.Id, On_Leave__c = False, IsActive = true);
        	
        	User busyAgencyUser = new User(firstname = 'Test',lastname = 'Agency Busy', email = 'testagency02@tesglobal.com',
        				  username = 'testagency02@tesglobal.com', profileid=permanentBookerProfile.id, alias = 'tsgagy02', 
        				  TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
        				  LanguageLocaleKey = 'en_US', UserRoleId = roleAgency.Id, On_Leave__c = False, IsActive = true);
        				  
        	User busyDirectUser = new User(firstname = 'Test',lastname = 'Direct Busy', email = 'testdirect01@tesglobal.com',
        				  username = 'testdirect01@tesglobal.com', profileid=permanentBookerProfile.id, alias = 'tsgdrt01', 
        				  TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
        				  LanguageLocaleKey = 'en_US', UserRoleId = roleDirect.Id, On_Leave__c = False, IsActive = true);
        	User busyDirectUser02 = new User(firstname = 'Test',lastname = 'Direct Busy 02', email = 'testdirect03@tesglobal.com',
        				  username = 'testdirect03@tesglobal.com', profileid=permanentBookerProfile.id, alias = 'tsgdrt03', 
        				  TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
        				  LanguageLocaleKey = 'en_US', UserRoleId = roleDirect.Id, On_Leave__c = False, IsActive = true);
        				  
        	User notBusyDirectUser = new User(firstname = 'Test',lastname = 'Agency Not Busy', email = 'testdirect02@tesglobal.com',
        				  username = 'testdirect02@tesglobal.com', profileid=permanentBookerProfile.id, alias = 'tsgdrt02', 
        				  TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
        				  LanguageLocaleKey = 'en_US', UserRoleId = roleDirect.Id, On_Leave__c = False, IsActive = true);
        				  
        	List<User> userList = new User[] { notBusyAgencyUser, busyDirectUser, notBusyDirectUser, busyDirectUser02, busyAgencyUser };
        	insert userList;
        	
        	//add a past busy time log for this user so he is not busy but was in the past.
        	Datetime dt = Datetime.now();
        	Datetime startDt = dt.addMinutes(-2);
        	String startTime = startDt.hour()+':'+startDt.minute();
        	Datetime endDt = dt.addMinutes(5);
        	String endTime = endDt.hour()+':'+endDt.minute();
        	Busy_Time_Log__c busyTimeLog = new Busy_Time_Log__c(User__c = busyDirectUser.Id,Date__c = Date.today(),
        									Start_Time__c = startTime,End_Time__c = endTime);
        	Busy_Time_Log__c busyTimeLog02 = new Busy_Time_Log__c(User__c = busyDirectUser02.Id,Date__c = Date.today(),
        									Start_Time__c = startTime,End_Time__c = endTime);
        	Busy_Time_Log__c busyTimeLog03 = new Busy_Time_Log__c(User__c = busyAgencyUser.Id,Date__c = Date.today(),
        									Start_Time__c = startTime,End_Time__c = endTime);
        	insert new Busy_Time_Log__c[] { busyTimeLog,busyTimeLog02,busyTimeLog03 };
        	
            User[] agencyUsers = [select Id,
                           RTF_Booking_Quota__c,
                           Current_Booking_Count__c
                    from User where (UserRole.Name = 'Customer Services Executive - Agency'
                          or UserRole.Name = 'Head of Customer Services - Agency'
                          or UserRole.Name = 'Customer Services Manager - Agency')
                          and Profile.Name != 'Temporary Booker'
                          and On_Leave__c = False and isactive = true
                    Order By Quota_Current_Diff__c DESC];
                    
            //make sure we have at least 1 agency user
            System.assertEquals(False,agencyUsers.isEmpty());
             
            //make sure our not busy user is part of the agency users.
            Boolean notBusyUserFound = False;
            for(User u : agencyUsers) {
            	if(u.Id == notBusyAgencyUser.Id) {
            		notBusyUserFound = True;
            		break;
            	}
            }    
            System.assertEquals(True,notBusyUserFound);
            
            List<Opportunity> oppsList = new List<Opportunity>();
            List<Opportunity> mappedOppList = new List<Opportunity>();
            for(Integer i=0; i < 5; i++) {
                Opportunity opp = new Opportunity();
                opp.Name='Test Booking' + i;
                opp.StageName='TBD';
                opp.CloseDate=Date.today();
                opp.RecordTypeId = SFDCBooking.Id;
                opp.Email_Status__c = 'Unread';
                opp.Order_By__c = c.Id;
                opp.AccountId = acc.Id;
                opp.Mailbox__c = directFolder.Id;
                oppsList.add(opp);
                mappedOppList.add(opp);
            }
            
            for(Integer i=0; i < 5; i++) {
                Opportunity opp2 = new Opportunity();
                opp2.Name='Test Booking' + i;
                opp2.StageName='TBD';
                opp2.CloseDate=Date.today();
                opp2.RecordTypeId = SFDCBooking.Id;
                opp2.Email_Status__c = 'Unread';
                opp2.Agency__c = acc.Id;
                opp2.Mailbox__c = agencyFolder.Id;
                
                oppsList.add(opp2);
            }
            
            insert oppsList;
            List<Id> newOpIds = new List<Id>();
            for(Opportunity opp : mappedOppList) {
            	newOpIds.add(opp.Id);
            }
            mappedOppList = [select Id,OwnerId,Name,StageName,CloseDate,RecordTypeId,Email_Status__c,Order_By__c from Opportunity where Id in :newOpIds];
            //all of the opportunites in the mapped opp list should be assigned to the same user.
            Id oppOwnerId = null;
            for(Opportunity opp : mappedOppList) {
            	if(oppOwnerId == null) {
            		oppOwnerId = opp.OwnerId;
            	}
            	System.assertEquals(oppOwnerId,opp.OwnerId);
            }
            
            //we should also try and insert a new opp of type one after this insert transaction.
            Opportunity afterOpp = new Opportunity();
            afterOpp.Name='Test Booking after opp';
            afterOpp.StageName='TBD';
            afterOpp.CloseDate=Date.today();
            afterOpp.RecordTypeId = SFDCBooking.Id;
            afterOpp.Email_Status__c = 'Unread';
            afterOpp.Order_By__c = c.Id;
            afterOpp.AccountId = acc.Id;
            afterOpp.Mailbox__c = directFolder.Id;
            
            insert afterOpp;
            
            afterOpp = [select Id,OwnerId from Opportunity where Id = :afterOpp.Id];
            System.assertEquals(oppOwnerId,afterOpp.OwnerId);
            
            //lets add 20 more opportunities. these should be random.
            //lets add 2 more direct users which are new now.
            List<User> nonBusyDirectUsers = new List<User>();
            for(Integer i = 0; i < 30; i++) {
	            User notBusyDirectUser02 = new User(firstname = 'Test',lastname = 'Agency Not Busy', email = 'testdirect04'+i+'@tesglobal.com',
	        				  username = 'testdirect04'+i+'@tesglobal.com', profileid=permanentBookerProfile.id, alias = 'tsgd04'+i, 
	        				  TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
	        				  LanguageLocaleKey = 'en_US', UserRoleId = roleDirect.Id, On_Leave__c = False, IsActive = true);
	        	nonBusyDirectUsers.add(notBusyDirectUser02);
            }
            insert nonBusyDirectUsers;
        	
            oppsList = new List<Opportunity>();
            for(Integer i=0; i < 20; i++) {
                Opportunity opp2 = new Opportunity();
                opp2.Name='Test Booking' + i;
                opp2.StageName='TBD';
                opp2.CloseDate=Date.today();
                opp2.RecordTypeId = SFDCBooking.Id;
                opp2.Email_Status__c = 'Unread';
                opp2.AccountId = directAcc.Id;
                opp2.Mailbox__c = directFolder.Id;
                oppsList.add(opp2);
            }
            insert oppsList;
            
            oppsList = new List<Opportunity>();
            for(Integer i=0; i < 20; i++) {
                Opportunity opp2 = new Opportunity();
                opp2.Name='Test Booking' + i;
                opp2.StageName='TBD';
                opp2.CloseDate=Date.today();
                opp2.RecordTypeId = SFDCBooking.Id;
                opp2.Email_Status__c = 'Unread';
                opp2.Mailbox__c = directFolder.Id;
                oppsList.add(opp2);
            }
            insert oppsList;
            
            //create a list of opportunities assigned to the contact without an account.
            Opportunity opp2 = new Opportunity();
            opp2.Name='Test Booking no account';
            opp2.StageName='TBD';
            opp2.CloseDate=Date.today();
            opp2.RecordTypeId = SFDCBooking.Id;
            opp2.Email_Status__c = 'Unread';
            opp2.Mailbox__c = directFolder.Id;
            insert opp2;
            opp2 = [Select Id,OwnerId,Name,StageName,CloseDate,RecordTypeId,Email_Status__c,AccountId from Opportunity where Id = :opp2.Id];
            
            OpportunityContactRole contactRole = new OpportunityContactRole(OpportunityId = opp2.Id,ContactId = uc.Id);
            insert contactRole;
            
            opp2.AccountId = acc.Id;
            update opp2;
            
            uc = [Select Id,AccountId from Contact where Id = :uc.Id];
            System.assertEquals(acc.Id,uc.AccountId);
            
            //now lets change the user this opportunity has been allocated to.
            Id currentUserId = opp2.OwnerId;
            Decimal currentBookingCount = [Select Id,Current_Booking_Count__c from User where Id = :currentUserId].Current_Booking_Count__c;
            User newUser = null;
            for(User u : userList) {
            	if(u.Id != opp2.OwnerId) {
            		newUser = u;
            		break;
            	}
            }
            
            opp2.OwnerId = newUser.Id;
            update opp2;
            
            User currentUser = [Select Id,Current_Booking_Count__c from User where Id = :currentUserId];
            System.assertEquals(currentBookingCount - 1,currentUser.Current_Booking_Count__c);
            Test.stopTest();
            //verify that the bookings are divided among each user
            
            //System.assertEquals(50, newUsers[1].Current_Booking_Count__c);
            //System.assertEquals(50, newUsers[2].Current_Booking_Count__c);
            
            
            //update stage to Check In and status to Email Complete of all new cases that belong to new users
            List<Opportunity> updateOpportunities = [SELECT Id, OwnerId from Opportunity Where Id =: oppsList And OwnerId =: currentUsers];  
            for(Opportunity opp : updateOpportunities) {
                
                opp.Email_Status__c = 'Booked';
                
            }
            
            update updateOpportunities;
            
            
            //verify that each user has 0 cases on their queue
            List<User> updatedUsrList = [SELECT Id, Current_Booking_Count__c FROM User WHERE Id =: currentUsers];
            

        }
        
    }
    
}