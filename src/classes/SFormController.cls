public class SFormController {

    public Sales_Form__c sForm {get;set;}
    
    public Contact contact {get; set;}
    
    public Sales_Form__c sFormstoUpdate {get;set;}
    
    public ApexPages.StandardController stdController;
    
    public sFormController(ApexPages.StandardController stdController) {
        sForm = new Sales_Form__c();
        contact = new Contact();
        this.stdController = stdController; 
    }
    
    public PageReference saveAndRedirect() {
        
        Savepoint sp = Database.setSavepoint(); 
        PageReference pr = null;
        RecordType cRecType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Customer Success'];
        
        try {
        
            insert sForm;
            
            if (sForm.Recruitment_Owner__c == null) {
                
                contact.RecordTypeId = cRecType.Id;
                insert contact;  
           
                sFormstoUpdate = [SELECT Id,Recruitment_Owner__c FROM Sales_Form__c WHERE Recruitment_Owner__c = null AND Id =: sForm.Id ];
                sFormstoUpdate.Recruitment_Owner__c = contact.Id;    
                    
                update sFormstoUpdate;
            }
            
            pr = new PageReference('/apex/salesFormThanks');
          
         }
        
        catch(DmlException e) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getdmlMessage(0));
            ApexPages.addMessage(msg);
            Database.rollback(sp); 
            sForm = sForm.clone(false);
            return null;
        }
       
        return pr;
        
    }
   
    
    
    
    public PageReference returnToForm() {
        PageReference sfPage = new PageReference('/apex/sForm');
        sfPage.setRedirect(True);
        return sfPage; 
     } 
    
}