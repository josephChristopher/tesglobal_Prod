global with sharing class CCAttachmentSearchController {
	@RemoteAction
	global static CCEmailArchiveService.OpportunityListResult searchAttachments(String searchText,Integer page) {
		return new CCEmailArchiveService().searchAttachments(searchText,page);
	}
}