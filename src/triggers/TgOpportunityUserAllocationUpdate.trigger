trigger TgOpportunityUserAllocationUpdate on Opportunity (before insert,before update,before delete,after insert,after update,after delete) {
    new OpportunityTriggerHandler().run();
}