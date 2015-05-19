@isTest
public with sharing class AccountTriggerHandlerTest {
	
	public static testMethod void testInsertAccountWithNoSchoolId() {
		Account testAccount = (Account) Reach.SmartFactory.createSObject('Account');
		
		testAccount.School_Id__c = null;
		
		insert testAccount;
		
	}
	
	public static testMethod void testInsertAccountAndLinkVacancy() {
		Account testAccount = (Account) Reach.SmartFactory.createSObject('Account');
		Vacancy__c testVacancy = (Vacancy__c) Reach.SmartFactory.createSObject('Vacancy__c');
		testVacancy.Vacancy_Position_and_Subject__c = '000';
		Survey_Template__c testSurverTemplate = new Survey_Template__c();
        testSurverTemplate.Name = 'TES Recruitment Two Minute Survey';
        
		//Sales_Form__c testSalesForm = (Sales_Form__c) Reach.SmartFactory.createSObject('Sales_Form__c');
		//Contact testSalesForm = (Contact) Reach.SmartFactory.createSObject('Contact');
		
		testAccount.School_Id__c = 1234;
		
		testVacancy.Vacancy_Employer__c = 1234;

        insert testSurverTemplate;		
		insert testVacancy;
		insert testAccount;
		
		testVacancy = [SELECT Id, Account__c FROM Vacancy__c WHERE id = :testVacancy.Id];
		System.assertEquals(testVacancy.Account__c, testAccount.Id);
		
	}

	
	public static testMethod void testInsertAccountAndLinkContact() {

		
		Account testAccount2 = (Account) Reach.SmartFactory.createSObject('Account');      		
		insert testAccount2;
        
		Contact testContact = (Contact) Reach.SmartFactory.createSObject('Contact');
		testContact.AccountId = testAccount2.Id;
		testContact.Email = 'javier.ciccarelli@cloudreach.co.uk';
		testContact.Salutation = 'Mr';
		testContact.LastName = 'Javier';
		testContact.Phone = '+3123123';
		
		insert testContact;
		
		Sales_Form__c testSalesForm = (Sales_Form__c) Reach.SmartFactory.createSObject('Sales_Form__c');
		testSalesForm.Recruitment_Owner__c = testContact.Id;
		testSalesForm.MSL_Ad_Number__c = '12345';
		testSalesForm.Salesperson_name__c = 'Test Name';
		
		insert testSalesForm;
		
		Survey_Template__c testSurverTemplate = new Survey_Template__c();
        testSurverTemplate.Name = 'TES Recruitment Two Minute Survey';     
        insert testSurverTemplate;
        	
		Vacancy__c testVacancy = (Vacancy__c) Reach.SmartFactory.createSObject('Vacancy__c');
		testVacancy.Vacancy_Position_and_Subject__c = '000';
		testVacancy.Vacancy_Employer__c = 1234;
		testVacancy.Sales_form__c = testSalesForm.Id;
		insert testVacancy;
        
  		Account testAccount = (Account) Reach.SmartFactory.createSObject('Account');
		testAccount.School_Id__c = 1234;
		insert testAccount;
		
		testVacancy = [SELECT Id, Account__c FROM Vacancy__c WHERE id = :testVacancy.Id];
		testContact = [SELECT Id, AccountId FROM Contact WHERE id = :testContact.Id];
		
		System.assertEquals(testVacancy.Account__c, testAccount.Id);
		System.assertEquals(testAccount.Id, testContact.AccountId);
	}

}