public class QmsFormController {
    
    public Case cs {get; set;}
    public Remedial_Action__c ra {get; set;}
    
    RecordType complaintsRT = [SELECT Id, Name 
                               FROM RecordType 
                               WHERE sObjectType = 'Case' 
                               AND Name = 'Complaints'];
    
    public ApexPages.StandardSetController stdSetController;
    public QmsFormController(ApexPages.StandardSetController stdSetController) {
        cs = new Case(origin = 'QMS', 
                      Reported_By_Team__c = 'Finance', 
                      Reported_By__c = 'Julia Rontree',
                      Status = 'Closed - Resolved', 
                      Main_Reason_for_Complaint__c = 'Invoice/Billing Issue', 
                      RecordTypeId = complaintsRT.Id
                     );
        
        ra = new Remedial_Action__c(Status__c = 'Credit Given', Approver_Name__c = 'Julia Rontree', Priority__c = '3 - Medium');
        
        this.stdSetController = stdSetController; 
    }
    
     public PageReference saveQMSForm() {
       Savepoint sp = Database.setSavepoint(); 
        
       try { 
           
       cs.RecordTypeId = complaintsRT.Id;    
      
       insert cs;
       
       ra.Case__c = cs.Id;
       ra.Reason_for_Credit__c = cs.Description;
       
       insert ra;
       
       PageReference pg = new PageReference('/' + cs.Id);
       return pg;      
           
       } catch(DmlException e) {
           ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getdmlMessage(0));
           ApexPages.addMessage(msg);
           Database.rollback(sp); 
           cs = cs.clone(false);
            return null;
        }
        
        return null;  
        
    }  

}