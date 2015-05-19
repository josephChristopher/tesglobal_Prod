global with sharing class CCEmailListController {
	
	private ApexPages.StandardController stdController = null;
	public List<TESMessage> messages { get; set; } 
	public Opportunity opp = null;
	public String lastJSON { get; set; }
	public Exception lastError { get; set; }
	private CCEmailArchiveService archiveService = new CCEmailArchiveService();
	
	public CCEmailListController(ApexPages.StandardController stdController) {
		this.stdController = stdController;
		this.opp = (Opportunity)stdController.getRecord();
		
		try {
			this.messages = archiveService.listMesssages(this.opp.Id);
		}catch(Exception ex) {
			lastError = ex;
		}
		
		this.lastJSON = archiveService.lastJsonResponse;
	}
	
	public String getMessagesAsJson() {
		CCMessageList msgList = new CCMessageList();
		msgList.messages = messages;
		return JSON.serialize(msgList);
	}
	
	global class CCMessageList {
		public List<TESMessage> messages = null;
	}
	
	@RemoteAction
	global static String getMessageBody(String uuid,String messagesJson) {
		CCMessageList messageList = (CCMessageList)JSON.deserialize(messagesJson,CCMessageList.class);
		for(TESMessage msg : messageList.messages) {
			if(msg.uuid == uuid) {
				return msg.body;
			}
		}
		
		return null;
	}
    
    @RemoteAction
    global static void toggleReadFlag(String bookingId) {
        Opportunity opp = [select Id,Read__c from Opportunity where Id = :bookingId];
        opp.Read__c = true;
        update opp;
    }
    
    @RemoteAction
    global static void toggleReplied(String bookingId) {
       	Opportunity opp = [select Id,Replied__c from Opportunity where Id = :bookingId];
        opp.Replied__c = true;
        update opp;
    }
    
  @RemoteAction
  global static List<OpportunityContactRole> getOpportunityContacts(String bookingId) {
  	return [Select Contact.Id,Contact.FirstName,Contact.LastName,Contact.Email,Contact.AccountId from OpportunityContactRole 
  					where OpportunityId = :bookingId
  					Order by Contact.FirstName,Contact.LastName];
  }
}