@isTest
public class TestUpdateProposalWhenClosed {

    static testMethod void TestUpdateProposalWhenClosed() {
        
       
        //insert Proposal
        Proposal__c p = new Proposal__c (
            Name = 'TEST',
            Proposed_Standard_Amount__c = 900,
            Proposed_Premium_Amount__c = 1000,
            Proposed_Premium_Products__c = 'Featured Job',
            Proposed_Standard_Products__c = 'Gold',
            Proposed_Print_Ad_Size__c = '12 x 13',
            Stage__c = 'Proposal/Price Quote'
        );
        
        insert p;
         test.startTest();
        //update proposal           
        p.Stage__c = 'Closed Won - Low';
        
        update p;
        test.stopTest();
        
        //validate booking amounts and products are populated
        
        Proposal__c pr = [SELECT Booked_Print_Ad_Size__c, Booked_Standard_Amount__c,Booked_Premium_Amount__c, Booked_Premium_Products__c, Booked_Standard_Products__c
                         FROM Proposal__c WHERE Id =: p.Id];

        
        system.assertEquals(900, pr.Booked_Standard_Amount__c);
        system.assertEquals(1000, pr.Booked_Premium_Amount__c);
        system.assertEquals('Featured Job', pr.Booked_Premium_Products__c);
        system.assertEquals('Gold', pr.Booked_Standard_Products__c);
        system.assertEquals('12 x 13', pr.Booked_Print_Ad_Size__c);
            
    }
}