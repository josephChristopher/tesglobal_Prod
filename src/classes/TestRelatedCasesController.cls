@isTest

public class TestRelatedCasesController {
    
    static testMethod void testRelatedCasesController(){
        
        RecordType caseRecType = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'Customer Success Case - Surveys'];
        
        Test.startTest();
        
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
        
        //create sales form
        Sales_Form__c sf = new Sales_Form__c();
        sf.MSL_Ad_Number__c = '100989';
        sf.Ad_Insert_MSL_ID__c = null;
        sf.Recruitment_Owner__c = c.Id;
        sf.Salesperson_Name__c = 'Claire Neary';
        
        insert sf;
        
        RecordType oppRecType = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'MSL Booking' LIMIT 1];
        
        //Insert booking.
        Opportunity opp = new Opportunity();
        opp.Name='Test Booking';
        opp.StageName='TBD';
        opp.CloseDate=Date.today();
        opp.RecordTypeId = oppRecType.Id;
        opp.Email_Status__c = 'Unread';
        
        insert opp;
    
    //insert survey template
        Survey_Template__c sTemp = new Survey_Template__c();
        sTemp.Name = 'TES Recruitment Two Minute Survey';
        
        insert sTemp;
        
    
    //create vacancy
   
        Vacancy__c v = new Vacancy__c();
        v.Name = 'Test';
        v.Ad_Insert_MSL_ID__c = '100989001';
        v.Ad_Number__c = '100989';     
        v.Account__c = acc.Id;
        v.Client_Name__c = acc.Id;
        v.Booking__c = opp.Id;
        v.Vacancy_Position_and_Subject__c = '789';
        v.Sub_Class_Text__c = 'TEST';

    insert v;
    
        
        Case cs = [SELECT Id, Vacancy__c, ContactId FROM Case WHERE Vacancy__c =: v.Id];
        
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(cs);
        relatedCasesController sc = new relatedCasesController(stdCtrl);

        Test.stopTest();
        
        sc.getRelatedCases();
        
    }
    
}