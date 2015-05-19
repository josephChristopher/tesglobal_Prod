trigger UpdateMarketShareCasePriority on Organisation__c (after update) {
    
    List<String> orgIds = new List<String>();
    Map<String, Organisation__c> orgMapbyId = new Map<String, Organisation__c>();
    
    for(Organisation__c org : Trigger.new) {
        if(Trigger.oldMap.get(org.Id).Priority__c != Trigger.newMap.get(org.Id).Priority__c) {
            orgIds.add(org.Id);
            orgMapbyId.put(org.Id, org);
        }
        
    }
    
    RecordType marketShareCaseRecType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Market Share Case' LIMIT 1];
        
    List<Case> casesToUpdate = [SELECT Id, SD_Name__c, Priority FROM Case WHERE SD_Name__c =: orgIds AND RecordTypeId =: marketShareCaseRecType.Id];
    
    for(Case cs : casesToUpdate) {
        Organisation__c org = orgMapbyId.get(cs.SD_Name__c);
        
        cs.Priority = org.Priority__c;
    }
    
    if(casesToUpdate.size() > 0) {
        update casesToUpdate;
    }
    

}