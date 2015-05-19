@isTest
public class TestUpdateFolderTgr {
    static testMethod void testUpdateFolder(){
        
    // Set up the Folder record.
    folder__c mailbox = new folder__c(Name= 'Agency - Online Only');
    insert mailbox;
      
    folder__c folder = new folder__c(Name= '1. Gold Agency');
    insert folder;  
    
    RecordType bookingRT = [SELECT Id FROM RecordType WHERE sObjectType = 'Opportunity' AND Name = 'SFDC Booking'];
        
    // Insert the Opportunity record.
    Opportunity opp = new Opportunity(Name='Test Booking', 
                                      StageName='TBD',
                                      CloseDate=Date.today(),
                                      Mailbox_Picklist__c = 'Agency - Online Only', 
                                      Folder_Picklist__c = '1. Gold Agency',
                                      RecordTypeId = bookingRT.Id );
    
    //Trigger to update Mailbox and Folder lookups should execute.
    insert opp;
        
    //Verify that the Mailbox and Folder lookup fields are updated with the IDs of the new folders added that 
    //has the same name as the picklist values selected.
    opp = [SELECT Mailbox_Picklist__c, Folder_Picklist__c, Mailbox__c, Folder__c 
           FROM Opportunity 
           WHERE Id = :opp.Id];
   
    System.assertEquals(mailbox.Id, opp.Mailbox__c);
    System.assertEquals(folder.Id, opp.Folder__c);  
    
    //Verify the trigger works on update.    
    opp.Mailbox_Picklist__c=null;
    opp.Folder_Picklist__c=null;
    update opp;
        
    opp = [SELECT Mailbox_Picklist__c, Folder_Picklist__c, Mailbox__c, Folder__c 
           FROM Opportunity 
           WHERE Id = :opp.Id];
   
    System.assertEquals(null, opp.Mailbox__c);
    System.assertEquals(null, opp.Folder__c);    
        
    }
}