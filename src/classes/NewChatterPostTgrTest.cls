@isTest
public class NewChatterPostTgrTest {
    static testMethod void testNewChatterPost(){
    
    // Insert the Opportunity record.
    Opportunity opp = new Opportunity(Name='Test Booking', 
                                      StageName='TBD',
                                      CloseDate=Date.today());
    insert opp;
        
    //Verify the opportunity has New_Chatter_Post__c as false.
    opp = [SELECT Name, New_Chatter_Post__c
          FROM Opportunity
          WHERE Id = :opp.Id];
    System.assertEquals(False, opp.New_Chatter_Post__c);
    
    // Insert the Feed Item.    
    FeedItem feed = new FeedItem(ParentId=opp.Id, Body='Hello', Title='Hello');
    insert feed;
        
    //Verify that the New_Chatter_Post__c field is set to true in the opportunity.
    opp = [SELECT Name, New_Chatter_Post__c
          FROM Opportunity
          WHERE Id = :opp.Id];
    System.assertEquals(True, opp.New_Chatter_Post__c);    
        
    }
}