global with sharing class CCEmailArchiveService {
	/*public static String listEndpoint = 'https://cloudreach-connect-shared.herokuapp.com/ccsvc/tes/email/list';
	public static String authKey = '2203ef9c-8c3f-44dd-bfcc-4ba67ae64406';
	
	public String lastJsonResponse { get; set; }
	
	public HTTPResponse sendCommand(String method,String endpoint,Map<String,String> paramList) {
		HTTPRequest request = new HTTPRequest();
		request.setEndpoint(endpoint);
		request.setHeader('AuthKey', authKey);
		request.setHeader('referer', System.URL.getSalesforceBaseUrl().toExternalForm());
		request.setMethod(method);
		request.setHeader('Content-Type','application/x-www-form-urlencoded');
		
		String reqBody = null;
		for(String paramKey : paramList.keySet()) {
			if(reqBody != null) {
				reqBody += '&';
			}
			String encodedParam = EncodingUtil.urlEncode(paramKey, 'UTF-8')+'='+EncodingUtil.urlEncode(paramList.get(paramKey),'UTF-8');
			reqBody = (reqBody == null ?  encodedParam : reqBody + encodedParam);
		}
		//reqBody = (reqBody == null ? 'key='+EncodingUtil.urlEncode(authKey,'UTF-8') : reqBody + '&key='+EncodingUtil.urlEncode(authKey,'UTF-8'));
		if(method == 'GET') {
			request.setEndpoint(endpoint+'?'+reqBody);
		} else {
			request.setHeader('Content-Length',String.valueOf(reqBody.length()));
			request.setBody(reqBody);
		}
		
		Http http = new Http();
		return http.send(request);
	}
	
	public TESMessage getFirstMessage(Id opportunityId) {
		Map<String,String> paramMap = new Map<String,String>();
		paramMap.put('oppId',opportunityId);
		paramMap.put('pos','FIRST');
		
		String jsonBody = sendCommand('GET',listEndpoint,paramMap).getBody();
		if(jsonBody != null && jsonBody.length() != 0) {
			return (TESMessage)JSON.deserialize(jsonBody,TESMessage.class);
		}
		
		return null;
	}
	
	public void moveMessage(String messageId,Id newOpportunityId) {
		Map<String,String> paramMap = new Map<String,String>();
		paramMap.put('oppId',newOpportunityId);
		paramMap.put('act','CHANGE_OPPORTUNITY');
		paramMap.put('msgId',messageId);
		
		String jsonBody = sendCommand('POST',listEndpoint,paramMap).getBody();
	}
	
	public class MessageList {
		public List<TESMessage> messages { get; set; }
	}
	
	public List<TESMessage> listMesssages(Id opportunityId) {
		Map<String,String> paramMap = new Map<String,String>();
		paramMap.put('oppId',opportunityId);
		
		String jsonList = sendCommand('GET',listEndpoint,paramMap).getBody();
		if(jsonList != null && jsonList.length() != 0) {
			String jsonBody = '{ "messages" : '+jsonList+'}';
			lastJsonResponse = jsonBody;
			MessageList msgList = (MessageList)JSON.deserialize(jsonBody,MessageList.class);
			
			return msgList.messages;
		}
		
		return new List<TESMessage>();
	}
	
	global class EmailAttachment {
		public Integer id = 0;
		public Integer inbox_id = 0;
		public String filename {set; get; }
		public String contentType = null;
		public Long file_length = 0;
		public String url {set; get; }
		public String opportunity_id = null;
	}
	
	public class EmailAttachmentList {
		public Integer currentPage { get; set; }
		public Integer totalPages { get; set; }
		public List<EmailAttachment> results { get; set; }
	}
	
	public class OpportunityResult {
		public Opportunity opportunity = null;
		public EmailAttachment attachment = null;
	}
	
	global class OpportunityListResult {
		public Integer numPages = 0;
		public Integer currentPage = 0;
		public Integer nextPage = 0;
		public Integer prevPage = 0;
		public List<OpportunityResult> results = null;
	}
	
	public OpportunityListResult searchAttachments(String searchText,Integer page) {
		OpportunityListResult result = new OpportunityListResult();
		
		//we need to execute the search for attachments remotely on the heroku server.
		Map<String,String> paramMap = new Map<String,String>();
		paramMap.put('act','ATTACHMENT_SEARCH');
		paramMap.put('pg',String.valueOf(page));
		paramMap.put('src',searchText);
		
		Map<Id,OpportunityResult> resultMap = new Map<Id,OpportunityResult>();
		String jsonList = sendCommand('POST',listEndpoint,paramMap).getBody();
		if(jsonList != null && jsonList.length() != 0) {
			EmailAttachmentList srcResult = (EmailAttachmentList)JSON.deserialize(jsonList,EmailAttachmentList.class);
			result.numPages = srcResult.totalPages;
			result.currentPage = srcResult.currentPage;
			if(page > 1) {
				result.prevPage = page - 1;
			} else {
				result.prevPage = page;
			}
			if(page < result.numPages) {
				result.nextPage = page + 1;
			} else {
				result.nextPage = page;
			}
			result.results = new List<OpportunityResult>();
			for(EmailAttachment attachment : srcResult.results) {
				OpportunityResult rowResult = new OpportunityResult();
				rowResult.attachment = attachment;
				result.results.add(rowResult);
				resultMap.put(attachment.opportunity_id,rowResult);
			}
		}
		Opportunity[] oppList = [Select Id,Name,CreatedDate,Account.Name,Ad_Number__c,Flag__c,Mailbox__r.Id,Mailbox__r.Name,
															Folder__r.Id,Folder__r.Name,Sales_Rep__r.Id,Sales_Rep__r.Name,Owner.Id,Owner.Name from Opportunity
															where Id in :resultMap.keySet()];
		for(Opportunity opp : oppList) {
			OpportunityResult rowResult = resultMap.get(opp.Id);
			rowResult.opportunity = opp;
		}
		//now make sure there are only results which are connected to an opportunity which exists.
		List<OpportunityResult> actualResults = new List<OpportunityResult>();
		for(OpportunityResult oppResult : result.results) {
			if(oppResult.opportunity != null) {
				actualResults.add(oppResult);
			}
		}
		result.results = actualResults;
		
		return result;
	}
	
	public List<EmailAttachment> getMessageAttachments(String messageId) {
		Map<String,String> paramMap = new Map<String,String>();
		paramMap.put('msgId',messageId);
		
		Map<Id,OpportunityResult> resultMap = new Map<Id,OpportunityResult>();
		String jsonList = sendCommand('GET',listEndpoint,paramMap).getBody();
		if(jsonList != null && jsonList.length() != 0) {
			EmailAttachmentList srcResult = (EmailAttachmentList)JSON.deserialize('{ "currentPage" : 1, "totalPages" : 0, "results" : '+jsonList+' }',EmailAttachmentList.class);
			return srcResult.results;
		}
		
		return new List<EmailAttachment>();
	}*/
}