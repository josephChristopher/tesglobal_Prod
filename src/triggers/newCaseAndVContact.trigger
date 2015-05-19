trigger newCaseAndVContact on Vacancy__c (before update) {
         
    
    List<Case> newCaseList = new List<Case>();
    List<Vacancy_Contact__c> newVacancyContactList = new List<Vacancy_Contact__c>();    
    List<String> vacancyIds = new List<String>();
    Boolean exclude;

    //Get all accounts for each vacancy
    Set<Id> accountIds = new Set<Id>();
    for (Vacancy__c v: Trigger.new)
      accountIds.add(v.account__c);

    List<Account> accounts = [SELECT Id, Not_England__c FROM Account WHERE Id IN :accountIds];
    Map<Id, Account> accountsById = new Map<Id, Account>();
    for (Account a : accounts)
      accountsById.put(a.Id, a);

    
    for(Vacancy__c v: Trigger.new) {  
        
        exclude = (v.Vacancy_Position_and_Subject__c != null && v.Vacancy_Position_and_Subject__c.startsWith('9')) 
                || (v.Sub_Class_Text__c != null && v.Sub_Class_Text__c.endsWith('TA'))
                || (v.Vacancy_Position_and_Subject__c != null && v.Vacancy_Position_and_Subject__c == '000')
                || (v.Account__c == null)
                || (accountsById.get(v.Account__c).Not_England__c);

        System.debug('v.Account__c: ' + v.Account__c);
        System.debug('v.Account__r.Not_England__c: ' + v.Account__r.Not_England__c);
        System.debug('v.Account__r.Name: ' + v.Account__r.Name);


        if(v.Sales_Form__c == null 
           && (exclude == FALSE)  
           && (v.Ad_Insert_MSL_ID__c != null || v.Ad_Number__c != null)  ) {
            vacancyIds.add(v.Ad_Insert_MSL_ID__c);
            vacancyIds.add(v.Ad_Number__c);
        }
        
    }
    
    List<Sales_Form__c> sFormAdInsertList = [SELECT Id, Ad_Insert_MSL_ID__c, MSL_Ad_Number__c, Salesperson_Name__c, Recruitment_Owner__c, Sales_Notes__c 
                                             FROM Sales_Form__c
                                             WHERE Ad_Insert_MSL_ID__c =: vacancyIds
                                             AND Ad_Insert_MSL_ID__c != null];  
    
    List<Sales_Form__c> sFormAdNumbersList = [SELECT Id, Ad_Insert_MSL_ID__c, MSL_Ad_Number__c, Salesperson_Name__c, Recruitment_Owner__c, Sales_Notes__c 
                                              FROM Sales_Form__c
                                              WHERE MSL_Ad_Number__c =: vacancyIds
                                              AND MSL_Ad_Number__c != null ];
    
    Map<String,Sales_Form__c> sFormByAdInsertId = new Map<String, Sales_Form__c>();
    
    for(Sales_Form__c sf : sFormAdInsertList)
        sFormByAdInsertId.put(sf.Ad_Insert_MSL_ID__c, sf);
    
    Map<String,Sales_Form__c> sFormByAdNumbers = new Map<String, Sales_Form__c>();
    for(Sales_Form__c sf : sFormAdNumbersList)
        sFormByAdNumbers.put(sf.MSL_Ad_Number__c, sf);
    
    
        for (Integer i = 0; i < Trigger.new.size(); i++) {
            
             exclude = (Trigger.new[i].Vacancy_Position_and_Subject__c != null && Trigger.new[i].Vacancy_Position_and_Subject__c.startsWith('9')) 
                || (Trigger.new[i].Sub_Class_Text__c != null && Trigger.new[i].Sub_Class_Text__c.endsWith('TA'))
                || (Trigger.new[i].Vacancy_Position_and_Subject__c != null && Trigger.new[i].Vacancy_Position_and_Subject__c == '000')
                || (Trigger.new[i].Account__c == null)
                || (accountsById.get(Trigger.new[i].Account__c).Not_England__c);

            
            if (Trigger.new[i].Sales_Form__c == null && sFormByAdInsertId.get(Trigger.new[i].Ad_Insert_MSL_ID__c) != null 
               && (exclude == FALSE )  
               ) { 
                Trigger.new[i].Sales_Form__c = sFormByAdInsertId.get(Trigger.new[i].Ad_Insert_MSL_ID__c).Id;
                Trigger.new[i].Sales_Notes__c = sFormByAdInsertId.get(Trigger.new[i].Ad_Insert_MSL_ID__c).Sales_Notes__c;
                Trigger.new[i].Salesperson__c = sFormByAdInsertId.get(Trigger.new[i].Ad_Insert_MSL_ID__c).Salesperson_Name__c;
                
                Vacancy_Contact__c vc = new Vacancy_Contact__c();
            
                vc.Contact__c = sFormByAdInsertId.get(Trigger.new[i].Ad_Insert_MSL_ID__c).Recruitment_Owner__c;
                vc.Vacancy__c = Trigger.new[i].Id;
                vc.Recruitment_Owner__c = TRUE;
                
                newVacancyContactList.add(vc);
            
            }       
        }      
   
        for (Integer i = 0; i < Trigger.new.size(); i++) {
        
        
             exclude = (Trigger.new[i].Vacancy_Position_and_Subject__c != null && Trigger.new[i].Vacancy_Position_and_Subject__c.startsWith('9')) 
                || (Trigger.new[i].Sub_Class_Text__c != null && Trigger.new[i].Sub_Class_Text__c.endsWith('TA'))
                || (Trigger.new[i].Vacancy_Position_and_Subject__c != null && Trigger.new[i].Vacancy_Position_and_Subject__c == '000')
                || (Trigger.new[i].Account__c == null)
                || (accountsById.get(Trigger.new[i].Account__c).Not_England__c);

            
            if (Trigger.new[i].Sales_Form__c == null && sFormByAdNumbers.get(Trigger.new[i].Ad_Number__c) != null
               && (exclude == FALSE )
               ) { 
                Trigger.new[i].Sales_Form__c = sFormByAdNumbers.get(Trigger.new[i].Ad_Number__c).Id;
                Trigger.new[i].Sales_Notes__c = sFormByAdNumbers.get(Trigger.new[i].Ad_Number__c).Sales_Notes__c;
                Trigger.new[i].Salesperson__c = sFormByAdNumbers.get(Trigger.new[i].Ad_Number__c).Salesperson_Name__c;
                
                Vacancy_Contact__c vc = new Vacancy_Contact__c();
            
                vc.Contact__c = sFormByAdNumbers.get(Trigger.new[i].Ad_Number__c).Recruitment_Owner__c;
                vc.Vacancy__c = Trigger.new[i].Id;
                vc.Recruitment_Owner__c = TRUE;
                
                newVacancyContactList.add(vc);
            }       
        }
            
    
    RecordType caseRecType = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'Customer Success Case - Surveys' LIMIT 1];
    Survey_Template__c sTemp = [SELECT Id FROM Survey_Template__c WHERE Name = 'TES Recruitment Two Minute Survey' ORDER BY CreatedDate DESC LIMIT 1];
    
    for(Vacancy__c v: Trigger.new) { 
        for (Integer i = 0; i < Trigger.new.size(); i++) {
        
         exclude = (Trigger.new[i].Vacancy_Position_and_Subject__c != null && Trigger.new[i].Vacancy_Position_and_Subject__c.startsWith('9')) 
                || (Trigger.new[i].Sub_Class_Text__c != null && Trigger.new[i].Sub_Class_Text__c.endsWith('TA'))
                || (Trigger.new[i].Vacancy_Position_and_Subject__c != null && Trigger.new[i].Vacancy_Position_and_Subject__c == '000')
                || (Trigger.new[i].Account__c == null)
                || (accountsById.get(Trigger.new[i].Account__c).Not_England__c);

        
        if(v.Case_Created__c == FALSE
          && (exclude == FALSE )  
          ) {
            
            Case custCase = new Case();
            
            custCase.Vacancy__c = v.id;
            custCase.AccountId = v.Account__c;
            custCase.Status = 'Pre-Check In';
            //custCase.Status_Custom__c = 'TBD';
            custCase.RecordTypeId = caseRecType.Id;
            custCase.Priority = v.Priority__c;
            custCase.Check_In_Call_Date__c = v.Check_In_Date__c;
            custCase.Customer_Care_Call_Date__c = v.Customer_Care_Call_Date__c;
            
            if(sFormAdInsertList.size() > 0 && sFormByAdInsertId.get(Trigger.new[i].Ad_Insert_MSL_ID__c) != null) {
                custCase.ContactId = sFormByAdInsertId.get(Trigger.new[i].Ad_Insert_MSL_ID__c).Recruitment_Owner__c;
      
             } else if(sFormAdNumbersList.size() > 0 && sFormByAdNumbers.get(Trigger.new[i].Ad_Number__c) != null) {
                custCase.ContactId =  sFormByAdNumbers.get(Trigger.new[i].Ad_Number__c).Recruitment_Owner__c;
             }
            
            newCaseList.add(custCase);

            v.Case_Created__c = TRUE;
            
        }
        
     }
        
 }
    
    insert newVacancyContactList;
    insert newCaseList;
    
    String instanceName = System.URL.getSalesforceBaseUrl().getHost();
    Boolean isSandbox = instanceName.startsWith('cs');
    Site surveySite = [select Id,subdomain from Site where urlpathprefix='CustomerSuccess'];
    
    
    for (case c : newCaseList) {
    
    if(c.ContactId != null && c.Check_In_Survey_Link__c == null) {
    c.Check_In_Survey_Link__c = 'https://'+(isSandbox ? 'dev-' : '')+surveySite.subdomain+'.'+instanceName.substring(0,instanceName.indexOf('.'))+'.force.com/CustomerSuccess'+'?id='+c.Id+'&survey='+sTemp.Id+'&contact='+c.ContactId;
     }     
   }
   
   
     
    update newCaseList;
                
             
}