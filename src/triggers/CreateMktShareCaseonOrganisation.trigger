trigger CreateMktShareCaseonOrganisation on Market_Share_Log__c (before insert) {
    
    List<String> OrgIds = new List<String>();
    List<Organisation__c> orgsToUpdate = new List<Organisation__c>();
    Map<String, Market_Share_Log__c> mSharebyOrgMap = new Map<String, Market_Share_Log__c>();
    
    List<Case> newMktShareCases = new List<Case>();
    RecordType marketShareCaseRecType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Market Share Case' LIMIT 1];
  
    for(Market_Share_Log__c ms: Trigger.new) {
            OrgIds.add(ms.SD_Name__c);
            mSharebyOrgMap.put(ms.SD_Name__c, ms);
        }
    
    orgsToUpdate = [SELECT Priority__c, Id, Local_Authority__c, (Select Id, RecordTypeId, Origin,SD_Name__c, Status, Status_Custom__c  FROM Cases__r WHERE RecordTypeId =: marketShareCaseRecType.Id AND SD_Name__c =: OrgIds) FROM Organisation__c WHERE Id =: OrgIds];    
    
    system.debug('org---' + orgsToUpdate);
    
    for(Organisation__c org: orgsToUpdate) {
        
        if(org.Cases__r.size() == 0) {
            
            Case cs = new Case();
            
            cs.RecordTypeId = marketShareCaseRecType.Id;
            cs.Origin = 'Marketshare Database';
            cs.SD_Name__c = org.Id;
            cs.Status = 'Engagement Contact';
            cs.Status_Custom__c = 'Awaiting Call';
            
            newMktShareCases.add(cs);
            
        }
        
        Market_Share_Log__c mSharebyOrgId = mSharebyOrgMap.get(org.Id);
        
          org.Current_Movement_Category__c = mSharebyOrgId.Current_Movement_Category__c;
          org.Volumes_YTD__c  = mSharebyOrgId.Volumes_YTD__c ;

              } 
    
    insert newMktShareCases;
    update orgsToUpdate;
    
    
    
        
    }