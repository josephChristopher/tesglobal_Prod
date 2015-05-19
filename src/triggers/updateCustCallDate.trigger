trigger updateCustCallDate on Metrics_Data__c (after update) {
    
    List<Case> casesToUpdate = new List<Case>();
    List<Id> mdCaseIds = new List<Id>();
    
    for (Metrics_Data__c md : Trigger.New) {
        
        if(md.Customer_Care_Call_Date__c != null) {
            mdCaseIds.add(md.Case__c);
            
        }
        
    }
    
    List<Case> caseList = [SELECT Id, Customer_Care_Call_Date__c, Care_Call_Date_Chosen_By_Contact__c 
                           FROM CASE
                           WHERE Id =: mdCaseIds
                           AND Care_Call_Date_Chosen_By_Contact__c = False];        
    
    
    for (Metrics_Data__c md : Trigger.New) {
        
        if(md.Customer_Care_Call_Date__c != null) {
            for (Case c: caseList) {
                c.Customer_Care_Call_Date__c = md.Customer_Care_Call_Date__c;
                c.Care_Call_Date_Chosen_By_Contact__c = true;
                casesToUpdate.add(c);
            }
            
        }
    }
    
    if(casesToUpdate.size() > 0) {
        update casesToUpdate;
    }
    
}