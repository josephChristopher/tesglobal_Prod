public class OpportunityEmailPageController {
    
    /*public Opportunity opportunity;

    public TESMessage firstEmail {set; get;}
    public Contact contact {set; get;}
    public Task fakeTask {set; get; }
    public List<CCEmailArchiveService.EmailAttachment> attachments { set; get; }
    
    public ApexPages.StandardController stdController;
    
    public OpportunityEmailPageController(ApexPages.StandardController stdController) {
        this.opportunity = (Opportunity) stdController.getRecord();
        this.stdController = stdController;
        
        /*List<Task> tasks = [
            SELECT Id, Description, Subject, ActivityDate, WhoId, WhatId
            FROM Task 
            WHERE whatId = :this.opportunity.Id 
            ORDER BY ActivityDate ASC LIMIT 1];
        
        if (tasks != null && !tasks.isEmpty()) {
            firstEmail = tasks.get(0);
        }
        fakeTask = new Task(WhatId = this.opportunity.Id);
        firstEmail = new CCEmailArchiveService().getFirstMessage(this.opportunity.Id);
        if(firstEmail != null) {
        	attachments = new CCEmailArchiveService().getMessageAttachments(firstEmail.uuid);
        }
        Opportunity fullOpp = [select Id,Order_By__c from Opportunity where Id = :this.opportunity.Id];
        List<Contact> contacts = [SELECT email, name FROM Contact WHERE Id = :fullOpp.Order_By__c];
            
        if (contacts != null && !contacts.isEmpty()) {
            this.contact = contacts.get(0);
        } 
        
    }
    
     public PageReference saveandredirect() {
         opportunity.Email_Status__c = 'Awaiting Booking';
         if(fakeTask.WhatId != null && fakeTask.WhatId != opportunity.Id) {
         	//we should call our archiving service and tell it to move this email to the selected opportunity
         	if(firstEmail != null) {
         		new CCEmailArchiveService().moveMessage(firstEmail.uuid,fakeTask.WhatId);
         	}
         	//we should also delete this opportunity as it would no longer make sense here.
         	delete this.opportunity;
         	
         	PageReference BookingListPage = new PageReference('/'+fakeTask.WhatId);
         	BookingListPage.setRedirect(true);
         	return BookingListPage;
         } else {
	         stdController.save();
	         PageReference BookingPage = new PageReference('/' + opportunity.Id);
	         BookingPage.setRedirect(true);
	         return BookingPage;
         }
     }*/
    
}