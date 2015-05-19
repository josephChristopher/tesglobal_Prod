trigger updateAcctSalesmanTgr on Account (before insert, before update) {
    
List<String> accounts = new List<String>(); 
    for (Account acc: trigger.new) {
        accounts.add(acc.Region__c);
        accounts.add(acc.MSL_Salesman__c);
        accounts.add(acc.Account_Salesperson__c);
    }
    
    List<Region__c> regionlist = [select name, Account_Salesperson__c, Salesman__c from Region__c where name in :accounts];
    
    Map<String, Region__c> regionByName = new Map<String, Region__c>();
    
    for (Region__c region : regionlist)
        regionByName.put(region.Name, region);
    
    if (regionlist.size() > 0 ) {
        
        for (Integer i = 0; i < Trigger.new.size(); i++) {
            if (Trigger.new[i].Region__c != null && regionByName.get(Trigger.new[i].Region__c) != null ) {
                //&& Trigger.new[i].MSL_Salesman__c == null){
                Trigger.new[i].MSL_Salesman__c = regionByName.get(Trigger.new[i].Region__c).Salesman__c;
                Trigger.new[i].Account_Salesperson__c = regionByName.get(Trigger.new[i].Region__c).Account_Salesperson__c;
            }
            
        }
              
    }        
}