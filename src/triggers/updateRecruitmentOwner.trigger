trigger updateRecruitmentOwner on Vacancy_Contact__c (before insert, before update) {
    
    String instanceName = System.URL.getSalesforceBaseUrl().getHost();
    Boolean isSandbox = [select Id, IsSandbox from Organization limit 1].IsSandbox;
    
    String url;
    if (isSandbox != TRUE) {
        url = 'https://tes.secure.force.com/';
     } else {
         String[] parts = instanceName.split('\\.');
         String instance;
         if (parts[0].startsWith('cs')) {
             instance = parts[0];
         } else {
             instance = parts[1];
         }
        url = 'https://dev-tesglobal.' + instance + '.force.com/';         
     }
    
    Survey_Template__c sTemp = [SELECT Id FROM Survey_Template__c WHERE Name = 'TES Recruitment Two Minute Survey' ORDER BY CreatedDate DESC LIMIT 1];

    List<Id> vacancyIds = new List<Id>();
    Map<Id, Vacancy_Contact__c> vacancyContactMap = new Map<Id, Vacancy_Contact__c>();
    
    for(Vacancy_Contact__c vc : Trigger.New) {
        if(vc.Recruitment_Owner__c == TRUE) {
            vacancyIds.add(vc.Vacancy__c);
            vacancyContactMap.put(vc.Vacancy__c, vc);
        }
    }
    
    RecordType  cRecType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Customer Success Case - Surveys' LIMIT 1];
        
    
    List<Case> caseList = new List<Case>([SELECT Id, Vacancy__c, ContactId, Check_In_Survey_Link__c 
                                          FROM Case 
                                          WHERE Vacancy__c in : vacancyIds
                                          AND RecordTypeId =: cRecType.Id
                                          AND ContactId = null
                                          AND Check_In_Survey_Link__c = null]);
    
        
    for(Vacancy_Contact__c vc : Trigger.New) {
    for(integer i = 0; i < caseList.size(); i++) {
            if (vc.Vacancy__c == caseList[i].Vacancy__c) {
                caselist[i].ContactId = vacancyContactMap.get(Trigger.new[i].Vacancy__c).Contact__c;
                
                caselist[i].Check_In_Survey_Link__c = url 
                    + 'CustomerSuccess'
                    + '?id='+caseList[i].Id
                    + '&survey='
                    + sTemp.Id
                    + '&contact='
                    + vacancyContactMap.get(Trigger.new[i].Vacancy__c).Contact__c;
                
                /*caselist[i].Check_In_Survey_Link__c = 'https://'
                    + (isSandbox ? 'dev-' : '')
                    + surveySite.subdomain    
                    + '.'
                    + instanceName.substring(0,instanceName.indexOf('.'))
                    + '.force.com/CustomerSuccess'
                    + '?id='+caseList[i].Id
                    + '&survey='
                    + sTemp.Id
                    + '&contact='
                    + vacancyContactMap.get(Trigger.new[i].Vacancy__c).Contact__c;*/
                
                System.debug('isSandbox: '  + isSandbox);
                System.debug('instanceName: ' + instanceName);
                System.debug('instanceName.substring: ' + instanceName.substring(0,instanceName.indexOf('.')));
                

            }
        }       
    }
    
    if(caseList.size() > 0) {
    update caseList;
    }
    
}