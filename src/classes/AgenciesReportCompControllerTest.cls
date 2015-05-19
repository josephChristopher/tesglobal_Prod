@isTest
private class AgenciesReportCompControllerTest {

	private static Account testAccount;
	private static Contact testContact;
	private static Opportunity testbooking;
	private static Survey_Template__c testSurveyTemplate;
	private static Vacancy__c testVacancy;


	private static void createTestObjects() {
		testAccount = (Account) Reach.SmartFactory.createSObject('Account');
		insert testAccount;

		testContact = (Contact) Reach.SmartFactory.createSObject('Contact');
		testContact.AccountId = testAccount.Id;

		testBooking = (Opportunity) Reach.SmartFactory.createSObject('Opportunity');
		testBooking.AccountId = testAccount.Id;

		insert testContact;
		insert testBooking;

		testSurveyTemplate = new Survey_Template__c();
        testSurveyTemplate.Name = 'TES Recruitment Two Minute Survey';
        insert testSurveyTemplate;

		testVacancy = (Vacancy__c) Reach.SmartFactory.createSObject('Vacancy__c');
		testVacancy.Booking__c = testBooking.Id;
		testVacancy.Vacancy_Position_and_Subject__c = '000';		
		testAccount.School_Id__c = 1234;
		testVacancy.Vacancy_Employer__c = 1234;

		insert testVacancy;
	}


	@isTest
	static void itShouldShowTheRightRecords() {
		// Given
		createTestObjects();

		OpportunityContactRole testOppContRole = 
			new OpportunityContactRole(opportunityId=testBooking.Id, contactId= testContact.Id, Role='Booker');

		insert testOppContRole;

		Ad_Web_Performance__c metric = new Ad_Web_Performance__c();
		metric.Date__c = Date.today().addDays(-1);
		metric.Vacancy__c = testVacancy.Id;
		insert metric;

		// When
		AgenciesReportCompController controller = new AgenciesReportCompController();
		controller.contactId = testContact.Id;
		controller.accountId = testAccount.Id;

		// Then
		System.assert(controller.reportLines != null);
		System.assertEquals(1, controller.reportLines.size());
		System.assertEquals(testVacancy.Id, controller.reportLines.get(0).vacancy.Id);
		System.assertEquals(testOppContRole.id, controller.reportLines.get(0).contactRole.Id);
	}

	@isTest
	static void itShouldNotDisplayRecordIfMetricAddedBeforeLastWeek() {
		// Given
		createTestObjects();

		OpportunityContactRole testOppContRole = 
			new OpportunityContactRole(opportunityId=testBooking.Id, contactId= testContact.Id, Role='Booker');

		insert testOppContRole;

		Ad_Web_Performance__c metric = new Ad_Web_Performance__c();
		metric.Date__c = Date.today().addDays(-8);
		metric.Vacancy__c = testVacancy.Id;
		insert metric;

		// When
		AgenciesReportCompController controller = new AgenciesReportCompController();
		controller.contactId = testContact.Id;
		controller.accountId = testAccount.Id;

		// Then
		System.assert(controller.reportLines == null || controller.reportLines.size() == 0);
	}

	@isTest
	static void itShouldNotDisplayRecordIfContactIsNoBooker() {
		// Given
		createTestObjects();

		OpportunityContactRole testOppContRole = 
			new OpportunityContactRole(opportunityId=testBooking.Id, contactId= testContact.Id, Role='OtherRole');

		insert testOppContRole;

		Ad_Web_Performance__c metric = new Ad_Web_Performance__c();
		metric.Date__c = Date.today().addDays(-1);
		metric.Vacancy__c = testVacancy.Id;
		insert metric;

		// When
		AgenciesReportCompController controller = new AgenciesReportCompController();
		controller.contactId = testContact.Id;
		controller.accountId = testAccount.Id;

		// Then
		System.assert(controller.reportLines == null || controller.reportLines.size() == 0);
	}
}