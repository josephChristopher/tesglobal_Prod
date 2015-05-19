trigger SD3ContactImport on Contact (after insert) 
{
    Set<Id> contactIds = new Set<Id>();
    Set<Double> contactSDID = new Set<Double>();
    RecordType contrectype = [SELECT Id FROM RecordType WHERE Name = 'SD3 School contact' LIMIT 1];
    
    for (Contact c : Trigger.new) 
        if(c.RecordTypeId == contrectype.Id && c.SD_ID__c!=null)
            contactSDID.add(c.SD_ID__c);
    
    if(contactSDID.size()>0)
    {
        List<Organisation__c> organizacion = [SELECT Id, School_Id__c FROM Organisation__c WHERE School_Id__c IN: contactSDID];

        Map<Double,Id> orgMap = new Map<Double,Id>();
        for(Organisation__c o : organizacion)
            orgMap.put(o.School_Id__c, o.Id);
        
        List<School_contact__c> scs = new List<School_contact__c>();
        for (Contact c : Trigger.new)
        {
            if(c.RecordTypeId == contrectype.Id && c.SD_ID__c!=null && orgMap.containsKey(c.SD_ID__c))
            {
                School_contact__c sc = new School_contact__c();
                sc.Contact__c = c.Id;
                sc.Organisation__c = orgMap.get(c.SD_ID__c);

                scs.add(sc);
            }
        }

        insert scs;
    }   
    
}

/*if(c.RecordTypeId == contrectype.Id)
        {
            if(c.Gen_Input__c == '0' || c.Gen_Input__c == 'NO')
                c.Gen__c = false;
            else if(c.Gen_Input__c == 'YES')
                c.Gen__c = true;

            if(c.LastName == '0')
                c.LastName = ''; 

            if(c.Email == '0')
                c.Email = ''; 

            c.Source__c = c.Source__c.toLowerCase().capitalize();
        }*/