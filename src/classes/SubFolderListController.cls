public class SubFolderListController {
    
    public Id elementId {get; set;}
    
    public SubFolderListController() {
     //   System.debug('HERREEE!!!!!!! -->' + elementId);
    //    subFolderList = [SELECT Id, Name FROM Folder__c WHERE parent_folder__c = :elementId];
      //  System.debug('Results!!!!!!! -->' + subFolderList);

    }
    
    public List<Folder__c> getSubFolderList() {
         System.debug('HERREEE!!!!!!! -->' + elementId);
        
        return [SELECT Id, Name FROM Folder__c WHERE parent_folder__c = :elementId ORDER BY Name ASC];
    }

}