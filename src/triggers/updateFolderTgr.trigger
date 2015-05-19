trigger updateFolderTgr on Opportunity (before insert, before update) {
    
    List<String> folders = new List<String>(); 
    for (Opportunity opp : trigger.new) {
        folders.add(opp.Mailbox_Picklist__c);
        folders.add(opp.Folder_Picklist__c);
    }
    
    List<folder__c> folderlist = [select id, name from folder__c where name in :folders];
    
    Map<String, Folder__c> folderByName = new Map<String, Folder__c>();
    
    for (Folder__c folder : folderlist)
        folderByName.put(folder.Name, folder);
    
    if (folderlist.size() > 0 ) {
        
        for (Integer i = 0; i < Trigger.new.size(); i++) {
             
            if (Trigger.new[i].Mailbox_Picklist__c != null) { 
                Trigger.new[i].Mailbox__c = folderByName.get(Trigger.new[i].Mailbox_Picklist__c).Id;
            } 
            
            if (Trigger.new[i].Folder_Picklist__c != null) {
                Trigger.new[i].Folder__c = folderByName.get(Trigger.new[i].Folder_Picklist__c).Id;
            } 
        }
           
    }
    
    for (Opportunity opp : Trigger.new) {
        if(opp.Mailbox_Picklist__c == null) {
            opp.Mailbox__c = null;
        }
        
        if(opp.Folder_Picklist__c == null) {
            opp.Folder__c = null;
        }
    }

}