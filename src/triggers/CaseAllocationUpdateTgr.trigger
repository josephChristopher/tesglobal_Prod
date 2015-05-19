trigger CaseAllocationUpdateTgr on Case (after update) {
    /*if (!CheckRecursive2.runOnce())
        return;
    Case[] caseList = Trigger.New;
    Case[] oldCaseList = Trigger.Old;
    Set<Id> caseIdList = new Set<Id>();
    Map<Id, Case> newCaseMap = new Map<Id, Case>();
    RecordType cstCaseRT = [SELECT Id FROM RecordType WHERE Name = 'Customer Success Case - Surveys' LIMIT 1];
    RecordType mktShareCaseRT = [SELECT Id FROM RecordType WHERE Name = 'Market Share Case' LIMIT 1];
    
    for(Case cs: caseList) {
        if(cs.RecordTypeId == cstCaseRT.Id || cs.RecordTypeId == mktShareCaseRT.Id) {
            caseIdList.add(cs.OwnerId);
            newCaseMap.put(cs.Id, cs);
        }
    }
    
    for(Case cs : oldCaseList) {
        if(cs.RecordTypeId == cstCaseRT.Id || cs.RecordTypeId == mktShareCaseRT.Id) {
            Case newCase = newCaseMap.get(cs.Id);
            if(newCase.OwnerId != cs.OwnerId) {
                caseIdList.add(cs.OwnerId);
            }
        }
    }
    
    System.debug('Case ID List: ' + caseIdList);
    List<AggregateResult> userIdMap = [SELECT OwnerId, count(Id) 
                                       FROM Case 
                                       WHERE Status_Custom__c NOT IN ('Email Complete','Call Complete','Closed - Resolved, Awaiting Booking','Closed - Resolved, No Booking', 'Closed - Not Resolved', 'Incomplete')
                                       AND OwnerId in :caseIdList
                                       GROUP BY OwnerId];
    
    Set<Id> userIdList = new Set<Id>();
   
    Map<Id, integer> userCaseCounter = new Map<Id,Integer>();
    
    for(AggregateResult c : userIdMap) {
        userIdList.add((Id)c.get('OwnerId'));
        userCaseCounter.put((Id)c.get('OwnerId'),(Integer)c.get('expr0'));
    }
    
    User[] userList = [SELECT Id, Current_Booking_Count__c, RTF_Booking_Quota__c from User where Id in :userIdList];
    
    for(User u : userList) {
        Integer numCases = userCaseCounter.get(u.Id);
        if(u.RTF_Booking_Quota__c == null) {
            u.RTF_Booking_Quota__c = 10;
        }
        if(numCases > 0) {
            u.Current_Booking_Count__c = numCases;
        }
    }
    update userList;*/
}