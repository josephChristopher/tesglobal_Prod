trigger newChatterPostTgr on FeedItem (after insert) {
    List<Opportunity> updates = new List<Opportunity>();
    for (FeedItem fi : Trigger.new) {
        if (fi.ParentId.getSObjectType() == Opportunity.SObjectType) {
            updates.add(new Opportunity(
                    Id = fi.ParentId,
                    New_Chatter_Post__c = TRUE
                    ));
        }
    }
    update updates;
}