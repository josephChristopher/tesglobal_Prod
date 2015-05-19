trigger UpdateAmbVisitDate on Event (before insert) {
    
    RecordType ambassadorVisitEventRT = [SELECT Id FROM RecordType WHERE sObjectType = 'Event' AND Name = 'Ambassador Visit'];
    RecordType marketShareCaseRT = [SELECT Id FROM RecordType WHERE sObjectType = 'Case' AND Name = 'Market Share Case' LIMIT 1];
    List<Id> eventWhatIds = new List<Id>();
    List<Case> eventCases = new List<Case>();
    List<Id> caseSchoolIds = new List<Id>();
    List<Organisation__c> schoolsScheduledForVisit = new List<Organisation__c>();
    Map<Id, Event> eventWhatIdsAndActivityDate = new Map<Id, Event>();
    Map<Id, Case> schoolIdsandCase = new Map<Id, Case>();
    Map<Id, Case> eventIdAndCase = new Map<Id, Case>();
    
    for(Event event: Trigger.New) {
        if(event.RecordTypeId == ambassadorVisitEventRT.Id) {
            eventWhatIdsAndActivityDate.put(event.WhatId, event);
            eventWhatIds.add(event.WhatId);
        }
    }
    
    eventCases = [SELECT Id, SD_Name__c FROM Case WHERE RecordTypeId =: marketShareCaseRT.Id AND Id =: eventWhatIds];
    
    for(Case cs: eventCases) {
        cs.Status = 'Ambassador Contact';
        cs.Status_Custom__c = 'Awaiting Visit';
        caseSchoolIds.add(cs.SD_Name__c);
        schoolIdsandCase.put(cs.SD_Name__c, cs);
        eventIdAndCase.put(eventWhatIdsAndActivityDate.get(cs.Id).Id, cs);
    }
    
    update eventCases;
    
    schoolsScheduledForVisit = [SELECT Id FROM Organisation__c WHERE Id =: caseSchoolIds];
    
    for(Organisation__c org : schoolsScheduledForVisit) {
        org.Scheduled_to_Visit__c = TRUE;
        org.Visit_Start_Date_Time__c = eventWhatIdsAndActivityDate.get(schoolIdsandCase.get(org.Id).Id).StartDateTime;
        org.Visit_End_Date_Time__c = eventWhatIdsAndActivityDate.get(schoolIdsandCase.get(org.Id).Id).EndDateTime; 
        org.Scheduled_Date_Start_Time__c = eventWhatIdsAndActivityDate.get(schoolIdsandCase.get(org.Id).Id).StartDateTime.format('hh:mm');
    	org.Scheduled_Date_End_Time__c = eventWhatIdsAndActivityDate.get(schoolIdsandCase.get(org.Id).Id).EndDateTime.format('hh:mm');
    }
    
    update schoolsScheduledForVisit;
    
    for(Event event: Trigger.New){
        if(eventIdAndCase.get(event.Id) != null)
        event.Organisation_Name__c = eventIdAndCase.get(event.Id).SD_Name__c;
    }

}