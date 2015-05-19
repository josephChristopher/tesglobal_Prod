public class ComplaintsFormController {
    
    public Case cs {get; set;}
    public String caseType {get;set;}
    public Boolean complaintCase {get;set;}
    public Boolean queryCase {get;set;}
    public Boolean commentCase {get;set;}
    public Boolean booking {get;set;}
    public Boolean customer {get;set;}
    public Boolean reporter {get;set;}
    
    
    public ApexPages.StandardSetController stdSetController;
    public complaintsFormController(ApexPages.StandardSetController stdSetController) {
        cs = new Case();
        
        this.stdSetController = stdSetController; 
    }

    
    /*public ApexPages.StandardController stdController;
    
    public complaintsFormController(ApexPages.StandardController stdController) {
        cs = new Case();
        this.stdController = stdController; 
    }*/
    
    
    public PageReference setCaseTypetoComplaint() {
        cs.RecordTypeId = complaintsRT.Id;
        complaintCase = True;
        queryCase = False;
        commentCase = False;
        booking = True;
        customer = True;
        reporter = True;
        return null;
    }
    
    public PageReference setCaseTypetoQuery() {
        cs.RecordTypeId = queryRT.Id;
        queryCase = True;
        complaintCase = False;
        commentCase = False;
        booking = True;
        customer = True;
         reporter = True;
        return null;
    }
    
    public PageReference setCaseTypetoComment() {
        cs.RecordTypeId = commRT.Id;
        commentCase = True;
        queryCase = False;
        complaintCase = False;
        booking = True;
        customer = True;
         reporter = True;
        return null;
    }
    
    
    
    RecordType complaintsRT = [SELECT Id, Name 
                               FROM RecordType 
                               WHERE sObjectType = 'Case' 
                               AND Name = 'Complaints'];
    
    RecordType commRT = [SELECT Id, Name 
                         FROM RecordType 
                         WHERE sObjectType = 'Case' 
                         AND Name = 'Comments/Suggestions'];
    
    RecordType queryRT = [SELECT Id, Name 
                          FROM RecordType 
                          WHERE sObjectType = 'Case' 
                          AND Name = 'Queries'];
    
    
    public PageReference saveComplaint() {
        
        Savepoint sp = Database.setSavepoint(); 
        PageReference pr = null;
        
        try {
            cs.Origin = 'Web Form';
            insert cs;
            
            pr = new PageReference('/apex/ThankYou');
            
        }
        
        catch(DmlException e) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getdmlMessage(0));
            ApexPages.addMessage(msg);
            Database.rollback(sp); 
            cs = cs.clone(false);
            return null;
        }
        
        return pr;
        
    }
    
    public PageReference saveComplaintInternal() {
        
        Savepoint sp = Database.setSavepoint(); 
        PageReference pr = null;
        
        try {
      
            
            if(cs.ContactId == null && (cs.AccountId != null || cs.School_Institution__c != null) && cs.Salutation__c == null && cs.Contact_Last_Name__c == null && cs.Contact_Phone__c == null 
               && cs.Contact_Email__c == null) {
                   
                   ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Please fill out all the required fields: Salutation, Last Name, Phone and Email in order to submit this case.' );
                    ApexPages.addmessage(msg);
                    return null;
                   
               } else {
                
                
           
              insert cs;
            
              pr = new PageReference('/apex/ThankYouIntl');
                  
               }
                       
        }
        
        catch(DmlException e) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getdmlMessage(0));
            ApexPages.addMessage(msg);
            Database.rollback(sp); 
            cs = cs.clone(false);
            return null;
        }
        
        return pr;
        
    }
   
  
   
   public PageReference complaintsForm() {
        PageReference pg = new PageReference('/apex/caseForm');
        pg.setRedirect(True);
        return pg; 
     } 
    
    
    public PageReference complaintsFormIntl() {
        PageReference pg = new PageReference('/apex/caseFormIntl');
        pg.setRedirect(True);
        return pg; 
     } 
}