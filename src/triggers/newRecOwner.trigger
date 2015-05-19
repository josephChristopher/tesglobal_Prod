trigger newRecOwner on Sales_Form__c (after update, after insert) {
    
    List<Vacancy__c> vList = new List<Vacancy__c>();
    Map<String, Sales_Form__c> sFormByAdInsertId = new Map<String, Sales_Form__c>();
    Map<String, Sales_Form__c> sFormByAdNumbers = new Map<String, Sales_Form__c>();
    List<Vacancy_Contact__c> newVacancyContactList = new List<Vacancy_Contact__c>(); 
    
 
    System.debug('Test 1');
    
    for (Sales_Form__c sf : Trigger.New) {       
         if(sf.Ad_Insert_MSL_Id__c != null && sf.Recruitment_Owner__c != null) {
            sFormByAdInsertId.put(sf.Ad_Insert_MSL_Id__c, sf);
             
         } else if (sf.MSL_Ad_Number__c  != null && sf.Recruitment_Owner__c != null) {
            sFormByAdNumbers.put(sf.MSL_Ad_Number__c, sf);
         }
    }
    

    vList = [SELECT Id, Sales_Form__c, Ad_Number__c, Ad_Insert_MSL_ID__c  FROM Vacancy__c
            WHERE Sales_Form__c = null AND (Ad_Insert_MSL_ID__c IN :sFormByAdInsertId.keySet() OR Ad_Number__c IN :sFormByAdNumbers.keySet())];
            
    
    System.debug('VACANCY LIST: ' + vList);

    for (Vacancy__c v : vList) {
        Sales_Form__c formFoundByAdNumber = sFormByAdNumbers.get(v.Ad_Number__c);
        System.debug('FOUND BY AD NUMBER: ' + formFoundByAdNumber);

        if (formFoundByAdNumber != null) {
            v.Sales_Form__c = formFoundByAdNumber.Id;
            v.Salesperson__c = formFoundByAdNumber.Salesperson_Name__c;
            v.Sales_Notes__c = formFoundByAdNumber.Sales_Notes__c;
            
            Vacancy_Contact__c vc1 = new Vacancy_Contact__c();
            
            vc1.Contact__c = formFoundByAdNumber.Recruitment_Owner__c;
            vc1.Vacancy__c = v.Id;
            vc1.Recruitment_Owner__c = TRUE;
            
            newVacancyContactList.add(vc1);
             
            
            System.debug('ASSIGNING FORM TO VACANCY: ' + formFoundByAdNumber.Id);
       
        } else {
        
            Sales_Form__c formFoundByAdInsertId = sFormByAdInsertId.get(v.Ad_Number__c);            
            System.debug('FOUND BY AD INSERT: ' + formFoundByAdInsertId);

            if (formFoundByAdInsertId != null) {
                v.Sales_Form__c = formFoundByAdInsertId.Id;
                v.Salesperson__c = formFoundByAdInsertId.Salesperson_Name__c;
                v.Sales_Notes__c = formFoundByAdInsertId.Sales_Notes__c;
                
                Vacancy_Contact__c vc2 = new Vacancy_Contact__c();
            
                
                vc2.Contact__c = formFoundByAdInsertId.Recruitment_Owner__c;
                vc2.Vacancy__c = v.Id;
                vc2.Recruitment_Owner__c = TRUE;
            
                newVacancyContactList.add(vc2);
                
            
                
            
            }
        }           
    }
    
    update vList;
    insert newVacancyContactList;
    
}