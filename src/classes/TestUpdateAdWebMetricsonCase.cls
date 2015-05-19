@isTest

public class TestUpdateAdWebMetricsonCase {
    
    static testMethod void testUpdateAdWebMetricsonCase(){
        
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
    
    //insert Ad Web Metrics
        Ad_Web_Performance__c a = new Ad_Web_Performance__c();
        a.Vacancy__c = v.Id;
        a.Campaign_Stage__c = 'Mid-Campaign';
        a.Date__c = Date.today();
        a.Job_Apply_Clicks__c = 25;
        a.Job_Views__c = 30;
        
        insert a;
        
        
        //verify that ad metrics on case are updated
        Case cs = [SELECT Id, Vacancy__c, Date__c, Job_Apply_Clicks__c,Job_Views__c FROM Case WHERE Vacancy__c =:v.Id LIMIT 1];
        
        system.assertEquals(25, cs.Job_Apply_Clicks__c);
        system.assertEquals(30, cs.Job_Views__c);
        system.assertEquals(date.today(), cs.Date__c);
        
        
    }
    
}