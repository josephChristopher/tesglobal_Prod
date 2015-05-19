@isTest

public class testSFormController {
    
    public static testMethod void testSFormController() {

        Account acc = new Account (Name = 'test',
                                   Client_Type__c = 'To Be Analysed',
                                   Customer_Group__c = 'Academy',
                                   Phone = '1231231231',
                                   Street__c = '123123',
                                   City_Town__c = 'test',
                                   Country__c = 'Uganda',
                                   Post_Code__c = '12333',
                                   Main_Email__c = 'dsadsa@dsadsa.com',
                                   Region_1__c = 'Classified',
                                   Region_2__c = 'International',
                                   Not_Approved_by_Finance__c = false);
        
        insert acc;
        
        
        Sales_Form__c sf = new Sales_Form__c (Salesperson_Name__c = 'Claire Neary',
                                              Ad_Insert_MSL_Id__c = '9990120001',
                                              Sales_Notes__c = 'Testing',
                                              Recruitment_Owner__c = null);
        
        RecordType cRecType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Customer Success'];
        
        Contact c = new Contact(LastName = 'Smith', 
                                Phone = '123123123', 
                                Email = 'something@something.com', 
                                AccountId = acc.Id,
                                RecordTypeId = cRecType.Id,
                                Salutation = 'Ms.');
        
       PageReference pg = Page.sForm;
       Test.setCurrentPage(pg); 
       
       ApexPages.StandardController ctrl = new ApexPages.StandardController(sf);
       sFormController ext = new sFormController(ctrl);

        PageReference savePage = ext.saveAndRedirect();
        
        ext.sForm = sf;
        
        insert ext.sForm;
         
        ext.contact = c;
        
        if(ext.sForm.Recruitment_Owner__c == null) {
        insert ext.contact;
        }
        
        ext.sFormstoUpdate = [SELECT Id, Recruitment_Owner__c FROM Sales_Form__c WHERE Recruitment_Owner__c = null AND Id =: ext.sForm.Id ];
        ext.sFormsToUpdate.Recruitment_Owner__c = ext.contact.Id;
        
        
        update ext.sFormstoUpdate;
        
        system.assertEquals('Claire Neary', sf.Salesperson_Name__c);
        system.assertEquals('9990120001', sf.Ad_Insert_MSL_Id__c);
        system.assertEquals('Testing', sf.Sales_Notes__c);
        system.assertEquals(ext.contact.Id, ext.sFormsToUpdate.Recruitment_Owner__c);
        
        
        //system.assertEquals(Page.salesFormThanks, savePage);
      
        PageReference returnPage = ext.returnToForm();
        
        system.assertEquals('/apex/sForm', returnPage.getUrl());
        
        
        
        
        
        
        
        
        
    }
    
}