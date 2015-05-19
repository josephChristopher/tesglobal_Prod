trigger deleteBookingTrg on Opportunity (after update) {
    
    List<Opportunity> oppstoDelete = [Select Id from Opportunity Where Delete__c = TRUE];
    
    for(Opportunity opp: Trigger.old){
        
        delete oppstoDelete;
    }   
    
}