@isTest(seealldata = true)

public class TestNewCaseAndVContact {
    
    static testMethod void testNewCaseAndVContact(){
        
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
        opp.AccountId = acc.Id;
        
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
    
    List<Vacancy__c> vList = [SELECT Id, Sales_Form__c, Account__c FROM Vacancy__c WHERE Id =: vacancyList];
    
    //verify that each vacancy has the right sales form
    for(Vacancy__c v : vList) {
        System.assertEquals(sf.Id, v.Sales_Form__c);
    }
    
    //verify that each vacancy has the right vacancy contact
    
    List<Vacancy_Contact__c> vContacts = [SELECT Id, Contact__c, Vacancy__c, Recruitment_Owner__c 
                                          from Vacancy_Contact__c 
                                          where Vacancy__c =: vacancyList LIMIT 1];
    
    for (Vacancy_Contact__c vContact : vContacts) {
        System.assertEquals(True, vContacts[0].Recruitment_Owner__c);
        System.assertEquals(sf.Recruitment_Owner__c, vContacts[0].Contact__c);
    }
    
    //verify that each vacancy has the right case created
    
    String instanceName = System.URL.getSalesforceBaseUrl().getHost();
    Boolean isSandbox = instanceName.startsWith('cs');
    Site surveySite = [select Id,subdomain from Site where urlpathprefix='CustomerSuccess'];
        
    Case caseRecordType = [SELECT RecordTypeId FROM Case WHERE RecordType.Name = 'Customer Success Case - Surveys' LIMIT 1];
    
    List<Case> cases = [SELECT Id, Vacancy__c, ContactId, Status, RecordTypeId, AccountId, Check_In_Survey_Link__c
                        FROM Case
                        where Vacancy__c =: vacancyList];
    
    for(Case cs : cases) {
        
        System.assertEquals(vList[0].Account__c, cs.AccountId);
        System.assertEquals('Pre-Check In', cs.Status);
        System.assertEquals(caseRecordType.RecordTypeId, cs.RecordTypeId);
        System.assertEquals(sf.Recruitment_Owner__c, cs.ContactId);
        System.assertEquals('https://'+(isSandbox ? 'dev-' : '')+surveySite.subdomain+'.'+instanceName.substring(0,instanceName.indexOf('.'))+'.force.com/CustomerSuccess'
                   + '?id='+cs.Id+'&survey='+sTemp.Id+'&contact='+cs.ContactId, cs.Check_In_Survey_Link__c);
        
        
    }
    
    
}

}