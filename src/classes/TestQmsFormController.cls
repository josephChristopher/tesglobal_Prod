@isTest
public class TestQmsFormController {
    
    public static testMethod void TestQmsFormController() {
        
        //insert account
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

        
        RecordType complaintsRT = [SELECT Id from RecordType WHERE sObjectType = 'Case' AND Name = 'Complaints']; 
        
        //insert new cases
        List<Case> newCases = new List<Case>();
        for(Integer i=0; i < 100; i++) {    
            
            Case cs = new Case(
                RecordTypeId = complaintsRt.Id,
                Salutation__c = 'ms.',
                School_Institution__c = 'test school',
                Contact_Last_Name__c = 'smith',
                Contact_Email__c = 'smith@dsadsa.com',
                Contact_Phone__c = '3213123',
                Reported_By__c = 'test',
                Reported_By_Team__c = 'test',
                Main_Reason_For_Complaint__c = 'test',
                Reason_For_Complaint__c = 'test',
                Description = 'test',
                AccountId = acc.Id
            );
            
             newCases.add(cs);
            
        }
            
            insert newCases;
        
        
         PageReference pg = Page.QmsForm;
            Test.setCurrentPage(pg); 
            
            ApexPages.StandardSetController setCtrl = new ApexPages.StandardSetController(newCases);
            QmsFormController ext = new QmsFormController(setCtrl);
            
            PageReference saveQMSForm = ext.saveQMSForm();
        
            delete newCases;
        
            saveQMSForm = ext.saveQMSForm();

    }

}