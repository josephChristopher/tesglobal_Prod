@isTest
public class TestCaseTriggerHandler {
    
    public static testMethod void TestCaseTriggerHandler() {
        
        Test.startTest();
        
        //create survey template
        Survey_Template__c sTemp = new Survey_Template__c();
        sTemp.Name = 'TES Recruitment Two Minute Survey';
        
        insert sTemp;
        
        //create account
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
        
        insert acc;
        
        RecordType oppRecType = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'MSL Booking' LIMIT 1];
        
        //Insert booking.
        Opportunity opp = new Opportunity();
        opp.Name='Test Booking';
        opp.StageName='TBD';
        opp.CloseDate=Date.today();
        opp.RecordTypeId = oppRecType.Id;
        opp.Email_Status__c = 'Unread';
        opp.AccountId = acc.Id;
        opp.Ad_Number__c = 'FFFFGH';
        
        insert opp;
        
        //insert vacancy
        
        Vacancy__c v = new Vacancy__c();
        v.Name = 'Test';
        v.Ad_Insert_MSL_ID__c = 'FFFFGH001';
        v.Ad_Number__c = 'FFFFGH';     
        v.Account__c = acc.Id;
        v.Client_Name__c = acc.Id;
        v.Booking__c = opp.Id;
        v.Vacancy_Position_and_Subject__c = '000';
        v.Sub_Class_Text__c = 'TEST';
        
        insert v;
        
        
        RecordType complaintsRT = [SELECT Id from RecordType WHERE sObjectType = 'Case' AND Name = 'Complaints']; 
        
        //insert new case
        
        Case cs = new Case(
            RecordTypeId = complaintsRt.Id,
            Salutation__c = 'ms.',
            School_Institution__c = 'test school',
            Contact_Last_Name__c = 'smith',
            Contact_Email__c = 'smith@dsadsa.com',
            Contact_Phone__c = '3213123',
            Reason_for_Complaint__c = 'Booking Error',
            Description = 'test',
            Main_Reason_for_Complaint__c = 'test',
            Reported_By__c = 'test',
            Reported_By_Team__c = 'test'
        );
        
        insert cs;
        
        //verify that booking and vacancy is null
        
        Case newCase =  [SELECT Ad_Insert_Id__c, Ad_Number__c, Booking__c, Vacancy__c FROM Case WHERE Id =: cs.Id];
        
        system.assertEquals(null, newCase.Booking__c);
        system.assertEquals(null, newCase.Vacancy__c);
        
        //update case ad number and ad insert id     
        
        cs.Ad_Number__c = 'FFFFGH';
        cs.Ad_Insert_Id__c = 'FFFFGH001';
        cs.AccountId = acc.Id;
        
        
        update cs;
        
        //verify case booking, vacancy and contact is updated
        
        Case updatedCase = [SELECT ContactId, Ad_Insert_Id__c, Ad_Number__c, Booking__c, Vacancy__c FROM Case WHERE Id =: cs.Id];
        Contact newContact = [SELECT Id, AccountId FROM Contact WHERE AccountId =: acc.Id];
        
        system.assertEquals(opp.Id, updatedCase.Booking__c); 
        system.assertEquals(v.Id, updatedCase.Vacancy__c);
        system.assertEquals(newContact.Id, updatedCase.ContactId);
        
        CaseTriggerHandler caseHandler = new CaseTriggerHandler();
        
        caseHandler.adInsertWasUpdated(cs, updatedCase);
        caseHandler.adNumberWasUpdated(cs, updatedCase);
        
        map<Id, Case> oldRecords = new map<Id, Case>();
        
        oldRecords.get(updatedCase.Id);
        
        map<Id, Case> newRecords = new map<Id, Case>();
        
        newRecords.get(updatedCase.Id);
        
        Test.stopTest();
        
    }
    
    
    public static testMethod void TestCaseTeamCreation() {
        
        UserRole AMBASSADOR_ROLE = [SELECT Id FROM UserRole WHERE Name = 'Ambassador' LIMIT 1];
        UserRole EE_ROLE = [SELECT Id FROM UserRole WHERE Name = 'Engagement Executive' LIMIT 1];
        UserRole AMBASSADOR_SUPERVISOR_ROLE = [SELECT Id FROM UserRole WHERE Name = 'Sales Manager' LIMIT 1];
        Profile AMBASSADOR_PROFILE = [SELECT Id FROM Profile WHERE Name = 'Ambassador' LIMIT 1];
        Profile EE_PROFILE = [SELECT Id FROM Profile WHERE Name = 'Engagement Executive' LIMIT 1];
        RecordType MARKETSHARECASE = [SELECT Id FROM RecordType WHERE Name = 'Market Share Case' LIMIT 1];
        
        User thisUser = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' and IsActive = true limit 1];
        
        System.runAs (thisUser) {
            
            //insert users for case team
            
            User EngagementExecutive = new User(firstname = 'Test',lastname = 'Name', email = 'testname@tesglobal.com',
                                                username = 'testname@tesglobal.com', profileid=EE_PROFILE.id, alias = 'testing', 
                                                TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
                                                LanguageLocaleKey = 'en_US', UserRoleId = EE_ROLE.Id, On_Leave__c = False, IsActive = true,
                                                RTF_Booking_Quota__c = 10);
            insert EngagementExecutive;
            
            User Ambassador = new User(firstname = 'Test',lastname = 'Name', email = 'testname2@tesglobal.com',
                                       username = 'testname2@tesglobal.com', profileid=AMBASSADOR_PROFILE.id, alias = 'testing2', 
                                       TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
                                       LanguageLocaleKey = 'en_US', UserRoleId = AMBASSADOR_ROLE.Id, On_Leave__c = False, IsActive = true
                                       );
            insert Ambassador;
            
            User AmbassadorSupervisor = new User(firstname = 'Test',lastname = 'Name', email = 'testname3@tesglobal.com',
                                                 username = 'testname3@tesglobal.com', profileid=AMBASSADOR_PROFILE.id, alias = 'testing3', 
                                                 TimeZoneSidKey = 'Europe/London', LocaleSidKey = 'en_GB', EmailEncodingKey = 'UTF-8',
                                                 LanguageLocaleKey = 'en_US', UserRoleId = AMBASSADOR_SUPERVISOR_ROLE.Id, On_Leave__c = False, IsActive = true
                                                 );
            insert AmbassadorSupervisor;
            
            //insert country
            Country__c country = new Country__c ();
            country.Name = 'TEST';
            country.title__c = 'TEST';
            country.part_of_uk__c = TRUE;
            
            insert country;
            
            //insert local authority
            Local_Authority__c localAuthority = new Local_Authority__c ();
            localAuthority.Name = 'Test Local Authority';
            localAuthority.Region__c = 'North West';
            localAuthority.Country__c = country.Id;
            
            insert localAuthority;
            
            //insert organisation
            Organisation__c org = new Organisation__c();
            org.Name = 'Test School';
            org.Address_1__c = 'Test Address 1';
            org.County__c = 'Test County';
            org.Postcode__c = '123321';
            org.Country__c = country.Id;
            org.local_authority__c = localAuthority.Id;
            
            insert org;
            
            //insert market share case
            Case mCase = new Case();
            mCase.RecordTypeId = MARKETSHARECASE.Id;
            mCase.SD_Name__c = org.Id;
            mCase.OwnerId = EngagementExecutive.Id;
            mCase.Origin = 'Marketshare Database';
            mCase.Status = 'Engagement Contact';
            
            insert mCase;
            
            test.startTest();
            //update market share case
            mCase.Priority = '1 - Very High';
            mCase.Status_Custom__c = 'Visit Complete';
            
            update mCase;
            
            test.stopTest();
            
        }
    }
    
    public static testMethod void TestCustomerSuccessCaseAllocation(){
        
        
    }
    
    
    
}