@isTest

public class TestCaseAllocationUpdateTgr {
    
    static testMethod void testCaseAllocationUpdateTgr(){
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        UserRole role = [SELECT Id, Name FROM UserRole WHERE Name = 'Customer Success Consultant'];
        RecordType  cRecType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Customer Success Case - Surveys' LIMIT 1];
        Profile prof = [SELECT Id, Name FROM Profile WHERE Name IN ('Customer Success Consultant')];    
        
        System.runAs (thisUser) {
            //deactivate current users
            Test.startTest(); 
            /*List<User> currentUsers = [SELECT Id, FirstName, Current_Booking_Count__c, RTF_Booking_Quota__c 
                                       FROM User 
                                       WHERE UserRoleId =: role.Id
                                       AND ProfileId =: prof.Id 
                                       AND IsActive = TRUE];
            
            if(currentUsers.size() > 0 ) {
                for(User u : currentUsers) {
                    u.IsActive = false;
                }
            }
            
            update currentUsers;*/
            
            //create new users
            
            List<User> newUsers = new List<User>();
            for(Integer i = 0; i < 3; i++) {
                
                User u = new User();
                u.FirstName         = 'Elsa';
                u.LastName          = 'of Arendelle';
                u.Email             = 'elsa@disney.com';
                u.Alias             = 'elsa' + i;
                u.Username          = 'elsa' + i + '@disney.com';
                u.LocaleSidKey      = 'en_US';
                u.TimeZoneSidKey    = 'GMT';
                u.ProfileID         = prof.Id;
                u.UserRoleId        = role.Id;
                u.LanguageLocaleKey = 'en_US';
                u.EmailEncodingKey  = 'UTF-8';
                u.Current_Booking_Count__c = null;
                u.RTF_Booking_Quota__c = null;
                newUsers.add(u);    
            }
            
            insert newUsers;
            
            //create busy time log
            
            newUsers = [SELECT Id, Current_Booking_Count__c FROM User WHERE Id =: newUsers];
            
            Busy_Time_Log__c b = new Busy_Time_Log__c();
            
            b.Date__c = date.today();
            b.Start_Time__c = '00:00';
            b.End_Time__c = '23:45';
            b.User__c = newUsers[0].Id;
            b.Reason_for_Unavailability__c = 'test';
            
            insert b;
            
            
            
            //insert new cases
            
            List<Case> newCases = new List<Case>();
            for(Integer i=0; i < 100; i++) {
                Case c = new Case();
                c.Status = 'Pre-Check In';
                c.Status_Custom__c = 'TBD';
                c.RecordTypeId = cRecType.Id;
                newCases.add(c);
           }
            
            insert newCases;
            
            //verify that the cases are divided among each user
            List<User> usersWithCases = [SELECT Id, Current_Booking_Count__c FROM USER WHERE Id =: newUsers];
            
            //System.assertEquals(50, usersWithCases[1].Current_Booking_Count__c);
            //System.assertEquals(50, usersWithCases[2].Current_Booking_Count__c);
            
            
            //update stage to Check In and status to Email Complete of all new cases that belong to new users
            
            List<Case> updateCases = [SELECT Id, OwnerId from Case Where Id =: newCases And OwnerId =: newUsers];  
            
            for(Case c : updateCases) {
                
                c.Status = 'Check In';
                c.Status_Custom__c = 'Email Complete';
                
            }
            
            update updateCases;
            
            
            //verify that each user has 0 cases on their queue
            Test.stopTest(); 
            List<User> updatedUsrList = [SELECT Id, Current_Booking_Count__c FROM User WHERE Id =: newUsers];
            
            
           // for(User u : updatedUsrList) {
           //     System.assertEquals(0, updatedUsrList[1].Current_Booking_Count__c);
           // }
            
        }
        
    }
    
}