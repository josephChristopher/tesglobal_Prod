public class RelatedCasesController {


    public ApexPages.StandardController stdCon;
    
    public Case cs;
    public Id caseContactId { get; set; }
    public Id csId {get; set;}
    public List<Case> caseList = new List<Case>();
    
    public RelatedCasesController (ApexPages.StandardController stdCon) {
        this.cs = (case) stdCon.getRecord();
        this.stdCon = stdCon;
        
        caseContactId = this.cs.ContactId;
        csId = this.cs.Id;
       
    }
    
    
    public List<Case> getRelatedCases() {
        
        
        caseList = [SELECT Id, CaseNumber, Check_In_Call_Date__c, Customer_Care_Call_Date__c, 
                               OwnerId, AccountId, Vacancy__c, ContactId, Priority, Status, Status_Custom__c, 
                               Account.Name, Vacancy__r.Name, Contact.LastName, Contact.FirstName, 
                               Owner.FirstName, Owner.LastName
                              FROM Case
                              
                              WHERE ContactId =: caseContactId
                              AND ContactId !=: null
                              AND Id !=: csId
                              AND ((Check_In_Call_Date__c = LAST_WEEK OR Check_In_Call_Date__c = THIS_WEEK)
                              OR (Customer_Care_Call_Date__c = LAST_WEEK OR Customer_Care_Call_Date__c = THIS_WEEK))
                              ORDER BY Check_In_Call_Date__c DESC];
        
        
        return caseList;
        
    }
    
}