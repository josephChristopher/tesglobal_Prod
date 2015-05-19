trigger newCaseCallLog on Case (after update) {
    
    /*List<Call_Log__c> callLogList = new List<Call_Log__c>();
    RecordType cstCaseRT = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Customer Success Case - Surveys' LIMIT 1];
    RecordType mktShareCaseRT = [SELECT Id FROM RecordType WHERE Name = 'Market Share Case' LIMIT 1];
    List<String> schoolIds = new List<String>();
    List<Organisation__c> listofSchoolsVisited = new List<Organisation__c>();
    
    for(Case c : Trigger.new) {
        
        if( (Trigger.oldMap.get(c.Id).Status != Trigger.newMap.get(c.Id).Status
        || Trigger.oldMap.get(c.Id).Status_Custom__c != Trigger.newMap.get(c.Id).Status_Custom__c)
           && !Validator_cls.hasAlreadyDone()
          && (Trigger.newMap.get(c.Id).RecordTypeId == cstCaseRT.Id
          || Trigger.newMap.get(c.Id).RecordTypeId == mktShareCaseRT.Id)) {
               
               Call_Log__c callLog = new Call_Log__c();
               
               callLog.Call_Date_Time__c = system.now();
               callLog.Old_Stage__c = Trigger.oldMap.get(c.Id).Status;
               callLog.Stage__c = c.Status;
               callLog.Old_Status__c = Trigger.oldMap.get(c.Id).Status_Custom__c;
               callLog.Status__c = c.Status_Custom__c;
               callLog.Case__c = c.Id;
               
               callLogList.add(callLog);
               
               Validator_cls.setAlreadyDone();
               
           }
        
        if(Trigger.newMap.get(c.Id).RecordTypeId == mktShareCaseRT.Id
           && Trigger.newMap.get(c.Id).Status_Custom__c == 'Visit Complete') {
               schoolIds.add(c.SD_Name__c);
           }
    }
    
    listofSchoolsVisited = [SELECT Id, Visited_by_Ambassador__c FROM Organisation__c WHERE Id =: schoolIds AND Visited_by_Ambassador__c = FALSE LIMIT 1];
    
    for(Organisation__c org : listofSchoolsVisited) {
        org.Visited_by_Ambassador__c = True;
        org.Date_Visited_by_Ambassador__c = system.today();
    }
    
    if(callLogList.size() >0) {
    
     insert callLogList;
     
     }
    
    update listofSchoolsVisited;*/

}