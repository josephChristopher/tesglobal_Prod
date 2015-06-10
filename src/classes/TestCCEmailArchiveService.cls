/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
global class TestCCEmailArchiveService {
	
	/*global static String testMessage = '{ "uuid":"1111", "subject":"test subject", "account_email_address": "test@tesglobal.com", "tes_mailbox_address": "international@tesglobal.com", "body":"test message body", "message_id":"id0000", "references_header":"aaa", "recieveDate":"0" }';
	
	global class EmailArchiveServiceMock implements HttpCalloutMock {
		global HTTPResponse respond(HTTPRequest req) {
			String endpoint = req.getEndpoint();
			String[] paramList = null;
			if(endpoint.indexOf('?') == -1) {
				paramList = req.getBody().split('&');
			} else {
				paramList = endpoint.substring(endpoint.indexOf('?')+1).split('&');
			}
			Id oppId = null;
			for(String param : paramList) {
				if(param.startsWith('oppId')) {
					oppId = param.substring(6);
				}
			}
			
			Opportunity opp = [select Name from Opportunity where Id = :oppId];
			HttpResponse res = new HttpResponse();
	        res.setHeader('Content-Type', 'application/json');
	        if(paramList.size() == 1) {
		        if(opp.Name == 'Test Booking OK') {
		        	res.setBody('[ '+testMessage+' ]');
		        } else if(opp.Name == 'Test Booking EX') {
		        	res.setBody('{ [ { aaaa } ] }');
		        }
	        } else if(paramList.size() == 2) {
	        	if(paramList[1].startsWith('pos') && paramList[1].indexOf('FIRST') != -1) {
	        		if(opp.Name == 'Test Booking OK') {
	        			res.setBody(testMessage);
	        		}
	        	}
	        } else if(paramList.size() == 3) {
	        	res.setBody('true');
	        }
	        res.setStatusCode(200);
	        return res;
    	}
	}
	/*
    @isTest(SeeAllData=false)
	public static void testAttachments() {
		Test.setMock(HttpCalloutMock.class, new EmailArchiveServiceMock());
		
		test.startTest();

        // Testing attachments
        service.searchAttachments('searchText', 1);
        
		test.stopTest();
	}
    
    @isTest(SeeAllData=false)
	public static void testListMessages() {
		Test.setMock(HttpCalloutMock.class, new EmailArchiveServiceMock());
		
		//test an opportunity id which will return a single item.
		Opportunity opp = new Opportunity(Name = 'Test Booking OK', StageName = 'TBD', CloseDate = Date.newInstance(2011,1,1));
		Opportunity oppKo = new Opportunity(Name = 'Test Booking KO', StageName = 'TBD', CloseDate = Date.newInstance(2011,1,1));
		insert new Opportunity[] { opp, oppKo };
		
		test.startTest();
		CCEmailArchiveService service = new CCEmailArchiveService();
		List<TESMessage> messageList = service.listMesssages(opp.Id);
		System.assertEquals(1,messageList.size());
		messageList = service.listMesssages(oppKo.Id);
		System.assertEquals(0,messageList.size());
		
		//we need to test the getFirstMessage method
		TESMessage firstMessage = service.getFirstMessage(opp.Id);
		System.assertEquals('1111',firstMessage.uuid);
		firstMessage = service.getFirstMessage(oppKo.Id);
		System.assertEquals(null,firstMessage);
		//we need to test the moveMessage method
		service.moveMessage('1111',opp.Id);

		test.stopTest();
	}
	
	@isTest(SeeAllData=false)
	public static void testTESMessage() {
		test.startTest();
		TESMessage msg = new TESMessage();
		msg.uuid = '1111';
		msg.subject = 'Test Subject';
		msg.account_email_address = 'test@tesglobal.com';
		msg.tes_mailbox_address = 'international@tesglobal.com';
		msg.body = 'test body';
		msg.message_id = 'msg0000';
		msg.references_header = 'ref0000';
		msg.recieveDate = Datetime.newInstance(2011,1,1,0,0,0).getTime();
		System.assertEquals(2011,msg.getDate().year());
		System.assertEquals(1,msg.getDate().month());
		System.assertEquals(1,msg.getDate().day());
		test.stopTest();
	}
	
	@isTest(SeeAllData=false)
	public static void testEmailListController() {
		Test.setMock(HttpCalloutMock.class, new EmailArchiveServiceMock());
		
		//test an opportunity id which will return a single item.
		Opportunity opp = new Opportunity(Name = 'Test Booking OK', StageName = 'TBD', CloseDate = Date.newInstance(2011,1,1));
		Opportunity oppKo = new Opportunity(Name = 'Test Booking KO', StageName = 'TBD', CloseDate = Date.newInstance(2011,1,1));
		Opportunity oppEx = new Opportunity(Name = 'Test Booking EX', StageName = 'TBD', CloseDate = Date.newInstance(2011,1,1));
		insert new Opportunity[] { opp, oppKo, oppEx };
		
		test.startTest();
		ApexPages.StandardController sc = new ApexPages.StandardController(opp);
		CCEmailListController listController = new CCEmailListController(sc);
		//test the getMessagesAsJson method
		String jsonMessageList = listController.getMessagesAsJson();
		System.assertNotEquals(null,jsonMessageList);
		//test the getMessageBody method
		String messageBody = CCEmailListController.getMessageBody('1111',jsonMessageList);
		System.assertEquals('test message body',messageBody);
		messageBody = CCEmailListController.getMessageBody('0000',jsonMessageList);
		System.assertEquals(null,messageBody);
		
		sc = new ApexPages.StandardController(oppEx);
		listController = new CCEmailListController(sc);
		test.stopTest();
	}*/
	
	@isTest(SeeAllData=false)
	public static void testCustomerSuccessController() {
		Account a = new Account(Name = 'Test Account', School_Id__c=1234567, Region__c = 'London');
		insert a;
		
		Contact ct = new Contact(FirstName = 'Chris', LastName = 'Stura', Phone = '0000', AccountId = a.Id, email = 'test@test.com', Salutation = 'Mr.');
		Contact ctNoVc = new Contact(FirstName = 'Alan', LastName = 'No Vacancy Contact', Phone = '0001', AccountId = a.Id, email = 'novc@test.com', Salutation = 'Mr.');
		insert new Contact[] { ct, ctNoVc };
		
		Survey_Template__c  surveyTemplate = new Survey_Template__c(Name = 'Mid-Campaign Check-In');
		insert surveyTemplate;
		
		Survey_Template__c twoMinuteSurvey = new Survey_Template__c(Name = 'TES Recruitment Two Minute Survey');
		insert twoMinuteSurvey;
		
		//add some survey metrics for test
		Metrics__c metric1 = new Metrics__c(Available_Values__c = 'Value 1\nValue 2', Category__c = 'Customer Satisfaction',
											Customer_Care_Call_Date__c = false, Metrics_Question__c = 'Question 1',
											Question_Format__c = 'Multiple Choice (One Answer)', Response_Weight__c = '10,20');
		insert metric1;
		
		Survey_Metrics__c surveyMetric1 = new Survey_Metrics__c(Metrics__c = metric1.Id, Order__c = 1, Question_Weight__c = 10, Survey_Template__c = surveyTemplate.Id);
		
		insert surveyMetric1;
		
		surveyMetric1 = [select Id,Name,Metrics__c,Order__c,Question_Weight__c,Survey_Template__c from Survey_Metrics__c where Id = :surveyMetric1.Id];
		
		//we need to add a fake vacancy object here.
		Opportunity opp = new Opportunity(Name = 'Test Booking OK', StageName = 'TBD', CloseDate = Date.newInstance(2011,1,1));
		insert opp;
		
		Sales_Form__c sf = new Sales_Form__c(MSL_Ad_Number__c = '0000', Salesperson_Name__c = 'Adrian Munro', Recruitment_Owner__c = ct.Id);
		Sales_Form__c sf1 = new Sales_Form__c(Ad_Insert_MSL_ID__c = '0000', Salesperson_Name__c = 'Adrian Munro', Recruitment_Owner__c = ct.Id);
		insert new Sales_Form__c[] { sf, sf1 };
		
		Vacancy__c v = new Vacancy__c(Name = 'Head Teacher', Booking__c = opp.Id, Vacancy_Position_and_Subject__c = '09', 
									  Sub_Class_Text__c = 'TAX', Ad_Insert_MSL_ID__c = '0000', Ad_Number__c = '0000', Account__c = a.Id, Vacancy_Employer__c=1234567);
		
		insert v;
		
		Case nonSurveyCase = new Case(Subject = 'Case number 1', Contact_Email__c = 'diego.villatora@thisisatest.com', 
                                   Contact_Phone__c = '08328810930');
		insert nonSurveyCase;
		
		Case c = [select Id,Vacancy__c from Case where Vacancy__c = :v.Id];
		
		test.startTest();
        
		ApexPages.StandardController sc = new ApexPages.StandardController(c);
		CustomerSuccessSurveyController surveyController = new CustomerSuccessSurveyController(sc);
		
		//test the getTemplatesAsOptions method
		List<SelectOption> options = surveyController.getTemplatesAsOptions();
		System.assertEquals(2,options.size());
		
		//test the parseValues method
		List<String> valueList = surveyController.parseValues('option 1\noption2');
		System.assertEquals(2,valueList.size()); 
		System.assertEquals(null,surveyController.parseValues(null));
		System.assertEquals(null,surveyController.getTemplateById(ct.Id));
		System.assertEquals(1,surveyController.listVacancyContacts().size());
		System.assertEquals(1,surveyController.getVacancyContacts().size());
		System.assertNotEquals(null,CustomerSuccessSurveyController.getVacancyContactById(ct.Id,c.Id));
		System.assertEquals(null,CustomerSuccessSurveyController.getVacancyContactById(c.Id,c.Id));
		System.assertEquals(1,surveyController.getVacancyContactForSurvey(ct.Id).size());
		System.assertNotEquals(null,surveyController.doCancel());
		surveyController.closePopup();
		surveyController.showPopup();
		surveyController.closeHelpPopup();
		surveyController.showHelpPopup();
		System.assertNotEquals(null,surveyController.getTemplateById(surveyTemplate.Id));
		System.assertEquals(true,CustomerSuccessSurveyController.saveSurvey(c.Id,surveyTemplate.Id,'{ "values" : [ { "key": "'+surveyMetric1.Name+'", "value": "value1" } ] }',ct.Id,true));
		System.assertEquals(false,CustomerSuccessSurveyController.saveSurvey(c.Id,surveyTemplate.Id,'{ "values" : [] }',ct.Id,true));
		System.assertEquals(false,CustomerSuccessSurveyController.saveSurvey(c.Id,twoMinuteSurvey.Id,'{ "values" : [] }',ct.Id,true));
		System.assertEquals(false,CustomerSuccessSurveyController.saveSurvey(c.Id,c.Id,'{ "values" : [] }',ct.Id,true));
		System.assertNotEquals(null,CustomerSuccessSurveyController.getInstanceName());
		System.assertEquals(true,CustomerSuccessSurveyController.sendSurvey(c.id,surveyTemplate.Id,ct.Id));
		
		//we now have to test creating a new contact
		System.assertEquals(null,CustomerSuccessSurveyController.createContact(nonSurveyCase.Id,'Mr.','Morgan','Now VC Contact','novc@test.com','0001'));
		System.assertEquals(ctNoVc.Id,CustomerSuccessSurveyController.createContact(c.Id,'Mr.','Morgan','Now VC Contact','novc@test.com','0001').Id);
		System.assertEquals(ct.Id,CustomerSuccessSurveyController.createContact(c.Id,'Mr.','Morgan','Now VC Contact','test@test.com','0001').Id);
		//System.assertNotEquals(null,CustomerSuccessSurveyController.createContact(c.Id,'Mr.','Morgan','Now VC Contact','test2@test.com','0001'));
		
		PageReference pageRef = new PageReference('/'+c.Id);
        pageRef.getParameters().put('survey', surveyTemplate.Id);
        pageRef.getParameters().put('contact', ct.Id);
        Test.setCurrentPage(pageRef);
        
        surveyController = new CustomerSuccessSurveyController(sc);
        
		test.stopTest();
	}
}