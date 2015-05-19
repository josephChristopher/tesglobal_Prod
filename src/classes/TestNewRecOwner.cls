@isTest(SeeAllData=true)

public class TestNewRecOwner {
    
    static testMethod void testNewRecOwner(){
        
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
        
        RecordType cRecType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Customer Success'];
        
        //create new contact
        Contact c = new Contact();
        c.LastName = 'smith';
        c.RecordTypeId = cRecType.Id;
        c.Phone = '12312312321';
        c.Email = 'asdsa@dadsa.com';
        c.AccountId = acc.Id;
        c.Salutation = 'Ms.';
        
        insert c;
        
        RecordType oppRecType = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'MSL Booking' LIMIT 1];
        
        
        //Insert booking.
        Opportunity opp = new Opportunity();
        opp.Name='Test Booking';
        opp.StageName='TBD';
        opp.CloseDate=Date.today();
        opp.RecordTypeId = oppRecType.Id;
        opp.Email_Status__c = 'Unread';
        
        insert opp;
        
        //create vacancies
        List<Vacancy__c> vacancyList = new List<Vacancy__c>();
        for(Integer i = 0; i < 100; i++) {
            Vacancy__c v = new Vacancy__c();
            v.Name = 'Test';
            v.Ad_Insert_MSL_ID__c = '1009890' + i;
            v.Ad_Number__c = '100989';     
            v.Account__c = acc.Id;
            v.Client_Name__c = acc.Id;
            v.Booking__c = opp.Id;
            v.Vacancy_Position_and_Subject__c = '789';
            v.Sub_Class_Text__c = 'TEST';

            vacancyList.add(v);
        }
        
        insert vacancyList; 
        
       
        
        //create vacancy with ad insert id
         Vacancy__c vacancy = new Vacancy__c();
            vacancy.Name = 'Test';
            vacancy.Ad_Insert_MSL_ID__c = '1HJG67001';
            vacancy.Ad_Number__c = '1HJG67';     
            vacancy.Account__c = acc.Id;
            vacancy.Client_Name__c = acc.Id;
            vacancy.Booking__c = opp.Id;
            vacancy.Vacancy_Position_and_Subject__c = '789';
            vacancy.Sub_Class_Text__c = 'TEST';
        
        insert vacancy;
        
        test.startTest();
        //create sales form
        Sales_Form__c sf = new Sales_Form__c();
        sf.MSL_Ad_Number__c = '100989';
        sf.Ad_Insert_MSL_ID__c = null;
        sf.Recruitment_Owner__c = c.Id;
        sf.Salesperson_Name__c = 'Claire Neary';
        
        insert sf;
        
       //create other sales form
         Sales_Form__c sf2 = new Sales_Form__c();
        sf2.MSL_Ad_Number__c = null;
        sf2.Ad_Insert_MSL_ID__c = '1HJG67001';
        sf2.Recruitment_Owner__c = c.Id;
        sf2.Salesperson_Name__c = 'Claire Neary';
        
        insert sf2;
        test.stopTest();
        
        List<Id> vacancyIds = new List<Id>();
        for(Vacancy__c v : vacancyList) {
            vacancyIds.add(v.Id);
        }
        
        List<Vacancy__c> vList = [SELECT Id, Sales_Form__c, Account__c FROM Vacancy__c WHERE Id =: vacancyIds LIMIT 1];
        //Vacancy__c vacancyWithAdInsert = [SELECT Id, Sales_Form__c, Account__c FROM Vacancy__c WHERE Id =: vacancy.Id LIMIT 1];
        
        //verify that each vacancy has the right sales form
        for(Vacancy__c v : vList) {
            System.assertEquals(sf.Id, v.Sales_Form__c);
        }
        
        //System.assertEquals(sf2.Id, vacancyWithAdInsert.Sales_Form__c);
        
        //verify that each vacancy has the right vacancy contact
        
        
        
        /*List<Vacancy_Contact__c> vContacts = [SELECT Contact__c, Recruitment_Owner__c 
                                              from Vacancy_Contact__c 
                                              where Vacancy__c =: vacancyIds LIMIT 1];

        
        for (Vacancy_Contact__c vContact : vContacts) {
            System.assertEquals(True, vContacts[0].Recruitment_Owner__c);
            System.assertEquals(sf.Recruitment_Owner__c, vContacts[0].Contact__c);
        }*/
        
        
        
    }
    
}