public with sharing class FolderViewPageController {
    
    public List<Folder__c> folderList {get; set;}
    
    
    public FolderViewPageController() {
        folderList = [SELECT Id, Name, List_View_URL__c FROM Folder__c WHERE Parent_Folder__c = NULL ORDER BY Name ASC];

    }
    
    

}