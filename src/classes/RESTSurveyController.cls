@RestResource(urlMapping='/Survey/*')
global with sharing class RESTSurveyController {
	@HttpPost
	global static Boolean saveSurvey(String caseId,String surveyId,String surveyData,String contactId) {
		return CustomerSuccessSurveyController.saveSurvey(caseId,surveyId,surveyData,contactId,true); 
	}
}