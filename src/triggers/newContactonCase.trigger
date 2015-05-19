trigger newContactonCase on Case (before insert, before update) {
    
    List<String> caseContactEmails = new List<String>();
    
    for(Case c : Trigger.New) {
        
        caseContactEmails.add(c.Contact_Email__c);
        
    }
    
    List<Contact> currentContactList = new List<Contact>();
    
    currentContactList = [SELECT Id, Email FROM Contact WHERE Email =: caseContactEmails AND Email != null AND Inactive__c = FALSE];
    
    Map<String, Contact> contactMap = new Map<String, Contact>(); 
    
    for(Contact ct : currentContactList) {
        contactMap.put(ct.Email, ct);
    }
    
    RecordType cRecType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Customer Success'];    
    List<RecordType> caseRectTypeList = 
        [SELECT Id, Name 
         FROM RecordType 
         WHERE sObjectType = 'Case' 
         AND Name IN ('Complaints', 'Comments/Suggestions', 'Queries' )];
    
    Map<Id, RecordType> caseRecTypeMap = new Map<Id, RecordType>();
    
    for(RecordType rt : caseRectTypeList) {
        caseRecTypeMap.put(rt.Id, rt);
    }
    
    List<Contact> newContacts = new List<Contact>();
    Map<Id, Contact> caseContactMap = new Map<Id, Contact>();
    
    for(Case c : Trigger.New) {
        
        if(contactMap.get(c.Contact_Email__c) != null && caseRecTypeMap.containsKey(c.RecordTypeId) && contactMap.containsKey(c.Contact_Email__c)  && c.ContactId == null) {
            
            c.ContactId = contactMap.get(c.Contact_Email__c).Id;
            System.debug('FIRST CONDITION TRUE, Contact ID updated: ' + c.ContactId);
            
        } else if(c.origin != 'QMS' 
                  && caseRecTypeMap.containsKey(c.RecordTypeId) 
                  && contactMap.containsKey(c.Contact_Email__c) == FALSE 
                  && c.AccountId != null 
                  && c.ContactId == null) {
            
            Contact ct = new Contact();
            
            ct.RecordTypeId = cRecType.Id;
            ct.FirstName = c.Contact_First_Name__c;
            ct.LastName = c.Contact_Last_Name__c;
            ct.Title_If_Other__c = c.Contact_Job_Title__c;
            ct.Salutation = c.Salutation__c;
            ct.Phone = c.Contact_Phone__c;
            ct.Email = c.Contact_Email__c;
            ct.AccountId = c.AccountId;
            
            newContacts.add(ct);
            caseContactMap.put(c.Id, ct);
            
            System.debug('SECOND CONDITION TRUE, New contact: ' + ct.LastName);

            
        } else if(c.origin == 'QMS' 
                  && caseRecTypeMap.containsKey(c.RecordTypeId) 
                  && contactMap.containsKey(c.Contact_Email__c) == FALSE 
                  && c.AccountId != null 
                  && c.ContactId == null
                  && c.Contact_Last_Name__c != null
                  && c.Contact_Phone__c != null
                  && c.Contact_Email__c != null
                  && c.Salutation__c != null) {
            
            Contact ct = new Contact();
            
            ct.RecordTypeId = cRecType.Id;
            ct.FirstName = c.Contact_First_Name__c;
            ct.LastName = c.Contact_Last_Name__c;
            ct.Title_If_Other__c = c.Contact_Job_Title__c;
            ct.Salutation = c.Salutation__c;
            ct.Phone = c.Contact_Phone__c;
            ct.Email = c.Contact_Email__c;
            ct.AccountId = c.AccountId;
            
            newContacts.add(ct);
            caseContactMap.put(c.Id, ct);
            
            System.debug('SECOND CONDITION TRUE, New contact: ' + ct.LastName);

         
        }
        
    }
    
    insert newContacts;
    
    for (Case c : Trigger.New) {
        Contact newContact = caseContactMap.get(c.Id);
        System.debug('Search for case with ID: ' + c.Id);

        if (newContact != null) {
            System.debug('Found case ' + newContact);

            c.ContactId = newContact.Id;
        }
    }
    
    
    


}