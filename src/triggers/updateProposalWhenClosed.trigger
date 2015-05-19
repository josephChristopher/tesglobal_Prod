trigger updateProposalWhenClosed on Proposal__c (before insert, before update) {
    
    List<Proposal__c> proposalsToUpdate = new List<Proposal__c>();
    
    for(Proposal__c p: Trigger.New) {
        if((p.Stage__c == 'Closed Won - Low' 
          || p.Stage__c == 'Closed Won - Medium'
          || p.Stage__c == 'Closed Won - High')
           && (p.Booked_Premium_Products__c == null
              && p.Booked_Standard_Products__c == null
              && p.Booked_Standard_Amount__c == null
              && p.Booked_Premium_Amount__c == null
              && p.Booked_Print_Ad_Size__c == null
              )
          ) {
              
              p.Booked_Premium_Products__c = p.Proposed_Premium_Products__c;
              p.Booked_Standard_Products__c = p.Proposed_Standard_Products__c;
              p.Booked_Premium_Amount__c = p.Proposed_Premium_Amount__c;
              p.Booked_Standard_Amount__c = p.Proposed_Standard_Amount__c;
              p.Booked_Print_Ad_Size__c = p.Proposed_Print_Ad_Size__c;
              
          }
    }

}