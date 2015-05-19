@isTest

public class TestMassAssignOpp {
    static testMethod void test_MassAssignOpp(){
            
        PageReference pageRef=Page.MassAssignOpportunities;
        
        Test.setCurrentPageReference(pageRef);
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        Opportunity o = new Opportunity(Name='Test Booking2', 
                                      StageName='TBD',
                                      CloseDate=Date.today(),
                                       OwnerId = thisUser.Id);
        insert o;
        
        
        List<Opportunity> oppsList = new List<Opportunity>();
        for(Integer i=0; i < 4; i++) {
            Opportunity opp = new Opportunity(Name='Test Booking' + i, 
                                      StageName='TBD',
                                      CloseDate=Date.today());
        oppsList.add(opp);
        }
        
        insert oppsList;

        
        MassAssignOpportunityController massAssignOpps = new MassAssignOpportunityController();
       
        massAssignOpps.tempOpp = o;
        
        apexpages.currentpage().getparameters().put('opportunityIDs', oppsList[0].Id + ',' + oppsList[1].Id  + ',' + oppsList[2].Id  + ',' + oppsList[3].Id);
        apexpages.currentpage().getparameters().put('retVal', oppsList[0].Id + ',' + oppsList[1].Id  + ',' + oppsList[2].Id  + ',' + oppsList[3].Id);     
        
        String opportunityIDs = apexpages.currentpage().getparameters().get('opportunityIDs');
        String retVal = apexpages.currentpage().getparameters().get('retVal');
        
        massAssignOpps.convertToList(opportunityIDs);
        
        PageReference pageRefSave = massAssignOpps.saveOpportunities();
         
        
        PageReference pageRefCancel = massAssignOpps.cancelAndReturn();
       
       
        
       
          }
        
    }