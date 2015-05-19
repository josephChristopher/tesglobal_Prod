trigger updateAdMetricsonCase on Ad_Web_Performance__c (before insert, before update) {
    
    List<Case> casesToUpdate = new List<Case>();
    List<Id> adMetricsVacancyIds = new List<Id>();
    
    for(Ad_Web_Performance__c ad : Trigger.New) {
        adMetricsVacancyIds.add(ad.Vacancy__c);  
    }


    RecordType  cRecType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Customer Success Case - Surveys' LIMIT 1];
        
    List<Case> caseList = [SELECT Id, Job_Views__c, Job_Apply_Clicks__c, Vacancy__c
                           FROM Case
                           WHERE Vacancy__c =: adMetricsVacancyIds
                           AND RecordTypeId =: cRecType.Id ];    
    
    for(Ad_Web_Performance__c ad : Trigger.New) {
        
        for(Case c : caseList) {
            c.Job_Views__c = ad.Job_Views__c;
            c.Job_Apply_Clicks__c = ad.Job_Apply_Clicks__c;
            c.date__c = ad.date__c;
            c.Ad_Web_Metrics_Complete__c = TRUE;
            casesToUpdate.add(c);
        }  
    }
    
    if(casesToUpdate.size() > 0) {
        update casesToUpdate;
    }
}