public class SchoolMapExtension {
    
    public ApexPages.StandardController stdController;
    public Organisation__c org {get; set;}
    public Double orgLat {get; set;}
    public Double orgLong {get; set;}
    public Double distance {get; set;}
    
    public List<String> phasesFilter {get; set;}
    public List<String> fundingGroupFilter {get; set;}
    public List<String> fundingTypeFilter {get; set;}
    
    public String currentOrgId {get; set;}
    
    public String phases {get{
        
        if(filterKeys.get('Phase').size() > 0) {
        
            phases = String.join(filterKeys.get('Phase'), '\',\'');
            return phases;
        }
        
        else {
            
            phases = null;
            
            return phases;
        }
    }
        set;}
     
    public String fundingGroups {get{
        
        if(filterKeys.get('Funding Group').size() > 0) {
        
        String fundingGroups = String.join(filterKeys.get('Funding Group'), '\',\'');
        return fundingGroups;
        }
        
        else{
            fundingGroups = null;
            
            return fundingGroups;
            
        }
    }
        set;}
    
    public List<Organisation__c> listofSchools {get 
    
    {
        List<Organisation__c> filteredList = new List<Organisation__c>();
        List<Organisation__c> allSchools = new List<Organisation__c>();
          
        if(org == null) {
          allSchools = [SELECT Id,School_Id__c, Days_Since_Last_Visit__c, Scheduled_to_Visit__c, Visited_by_Ambassador__c, Phase_and_Funding_Group__c, Funding_Group__c, Name, lat_long__c,lat_long__Latitude__s, lat_long__Longitude__s, Complete_Address__c, Phase__c, Phone_Number__c, Current_Movement_Category__c FROM Organisation__c WHERE Country_Text__c = 'England' AND (Status__c = 'Open' OR Status__c = 'Proposed to open') AND School_Type__c = 'Mainstream School' AND (Phase__c includes ('Secondary') OR Phase__c = 'Multi-Phase')];
      	  return allSchools;
        }
        
        else if(phases == null && fundingGroups == null) {
   
        return listofSchools;
            
        }
        
        else{
        
        filteredList = Database.query('SELECT Id,School_Id__c, Scheduled_to_Visit__c, Days_Since_Last_Visit__c, Visited_by_Ambassador__c, Phase_and_Funding_Group__c, Funding_Group__c, Name, lat_long__c,lat_long__Latitude__s, lat_long__Longitude__s, Complete_Address__c, Phase__c, Phone_Number__c, Current_Movement_Category__c FROM Organisation__c WHERE Id =: currentOrgId OR ((Funding_Group__c IN (\''+fundingGroups+'\') OR Phase__c INCLUDES (\''+phases+'\')) AND (Status__c = \'Open\' OR Status__c = \'Proposed to open\') AND Distance(lat_long__c, GEOLOCATION('+orgLat+', '+orgLong+'),\'km\') < '+distance+')'); 
        return filteredList;
            
        }
      
    } set;}
    
    
    public Map<String, List<SelectOption>> filterMap {get; set;}
    public Map<String, List<string>> filterKeys {get; set;}
    
    public SchoolMapExtension() {
      
    }
    
    public SchoolMapExtension(ApexPages.StandardController stdController) {
        
        phasesFilter = new List<String>();
        fundingGroupFilter = new List<String>();
        fundingTypeFilter = new List<String>();  
        
        filterKeys = new Map<String, List<String>> {
                'Phase' => phasesFilter,
                'Funding Group' => fundingGroupFilter,
                'Funding Type' => fundingTypeFilter   
                };
                    
        createfilterMap();
        
        system.debug('filters-->' + filterKeys);
        
        //this.stdController = stdController; 
        org = (Organisation__c)stdController.getRecord();
        
        distance = 15;
        
        if(org != null) { 
            
            org = [SELECT Id, Phase__c, Phase_and_Funding_Group__c, Scheduled_to_Visit__c, Days_Since_Last_Visit__c , Visited_by_Ambassador__c, Funding_Group__c, School_Id__c, lat_long__c, Name,Latitude__c,Longitude__c, lat_long__Latitude__s, lat_long__Longitude__s FROM Organisation__c WHERE Id =: ApexPages.currentPage().getParameters().get('id')];
            orgLat = org.Latitude__c;
            orgLong = org.Longitude__c;
            currentOrgId = org.Id;
            phases = null;
            fundingGroups = null;
            
            listofSchools = [SELECT Id,School_Id__c, Days_Since_Last_Visit__c, Visited_by_Ambassador__c, Scheduled_to_Visit__c, Phase_and_Funding_Group__c, Funding_Group__c, Name, lat_long__c,lat_long__Latitude__s, lat_long__Longitude__s, Complete_Address__c, Phase__c, Phone_Number__c, Current_Movement_Category__c FROM Organisation__c WHERE Id =: ApexPages.currentPage().getParameters().get('id')]; 
            
        }
        
    }
 
    
    public void createfilterMap(){
        filterMap = new Map<String, List<SelectOption>>();
        List<SelectOption> options = new List<SelectOption>();
        
        for(String s : filterKeys.keyset()) {
            if(s == 'Phase') {
                options = new List<SelectOption>();
                
                Schema.DescribeFieldResult fieldResult = 
                Organisation__c.Phase__c.getDescribe();
                List<Schema.PicklistEntry> phaseList = fieldResult.getPicklistValues();
        
                for( Schema.PicklistEntry phase : phaseList) {
                    options.add(new SelectOption(phase.getLabel(), phase.getValue()));
                }
                
                filterMap.put('Phase', options);
  
            }
            
            if (s == 'Funding Group') {
                options = new List<SelectOption>();
                
                Schema.DescribeFieldResult fieldResult = 
                Organisation__c.Funding_Group__c.getDescribe();
                List<Schema.PicklistEntry> fgList = fieldResult.getPicklistValues();
        
                for( Schema.PicklistEntry fg : fgList) {
                    options.add(new SelectOption(fg.getLabel(), fg.getValue()));
                }
                
                filterMap.put('Funding Group', options);
                 
            }
            
        }
    }
    
}