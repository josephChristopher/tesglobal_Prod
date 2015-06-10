@isTest
private class TestB2CAccountUpdater {
	@isTest
	static void itShouldUpdateBillingDetailsInAccount() {
		// Given
		Id recTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'B2C Account'].Id;
		Id contRecTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'B2C'].Id;

		Account acc = new Account(
			name = 'Test Account', 
			Billing_First_Name__c = 'Javier', 
			Billing_Last_Name__c = 'Ciccarelli', 
			RecordTypeId = recTypeId, 
			Billing_Email_Address__c = 'test.email@cloudreach.co.uk',
			BillingStreet = 'Test street 123',
			BillingCity = 'London',
			BillingPostalCode = 'NW8 8UA',
			BillingCountry = 'United Kingdom',
			Billing_Phone__c = '429544510');

		insert acc;

		List<Contact> primaryContacts = [SELECT Id, FirstName, LastName, RecordTypeId, Email, MailingStreet, MailingCity, MailingPostalCode, MailingCountry 
											FROM Contact 
											WHERE AccountId = :acc.Id 
												AND Type__c = 'Primary'];
		primaryContacts.get(0).MailingCountry = 'Argentina';
		primaryContacts.get(0).MailingStreet = 'A new street';
		primaryContacts.get(0).MailingCity = 'Adrogue';
		primaryContacts.get(0).FirstName = 'Javier2';
		primaryContacts.get(0).LastName = 'Ciccarelli2';
		primaryContacts.get(0).Email = 'test@tes.co.uk';
		primaryContacts.get(0).Phone = '1234';



		// When
		Test.startTest();
		B2CSyncRecursiveCheck.alreadyRun = false;
		update primaryContacts.get(0);
		
		Test.stopTest();

		// Then
		Account updatedAccount = [SELECT Billing_First_Name__c, Billing_Last_Name__c, 
			Billing_Email_Address__c, BillingStreet, BillingCity,
			BillingPostalCode, BillingCountry, Billing_Phone__c FROM Account WHERE Id = :acc.Id];

		System.assertEquals('Argentina', updatedAccount.BillingCountry);
		System.assertEquals('A new street', updatedAccount.BillingStreet);
		System.assertEquals('Adrogue', updatedAccount.BillingCity);
		System.assertEquals('Javier2', updatedAccount.Billing_First_Name__c);
		System.assertEquals('Ciccarelli2', updatedAccount.Billing_Last_Name__c);
		System.assertEquals('test@tes.co.uk', updatedAccount.Billing_Email_Address__c);
		System.assertEquals('1234', updatedAccount.Billing_Phone__c);


	}
@isTest
	static void itShouldUpdateShipingDetailsInAccount() {
		// Given
		Id recTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'B2C Account'].Id;
		Id contRecTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = 'B2C'].Id;

		Account acc = new Account(
			name = 'Test Account', 
			Billing_First_Name__c = 'Javier', 
			Billing_Last_Name__c = 'Ciccarelli', 
			RecordTypeId = recTypeId, 
			Billing_Email_Address__c = 'test.email@cloudreach.co.uk',
			BillingStreet = 'Test street 123',
			BillingCity = 'London',
			BillingPostalCode = 'NW8 8UA',
			BillingCountry = 'United Kingdom',
			Billing_Phone__c = '429544510',

			Shipping_First_Name__c = 'JavierShip', 
			Shipping_Last_Name__c = 'CiccarelliShip', 
			Shipping_Email_Address__c = 'test.email@cloudreach.co.uk',
			ShippingStreet = 'Test street 123Ship',
			ShippingCity = 'LondonShip',
			ShippingPostalCode = 'NW8 8US',
			ShippingCountry = 'United Kingdom',
			Shipping_Phone__c = '429544511'
			);

		insert acc;

		List<Contact> shippingContacts = [SELECT Id, FirstName, LastName, RecordTypeId, Email, MailingStreet, MailingCity, MailingPostalCode, MailingCountry 
											FROM Contact 
											WHERE AccountId = :acc.Id 
												AND Type__c = 'Shipping'];
		shippingContacts.get(0).MailingCountry = 'Argentina';
		shippingContacts.get(0).MailingStreet = 'A new street';
		shippingContacts.get(0).MailingCity = 'Adrogue';
		shippingContacts.get(0).FirstName = 'Javier2';
		shippingContacts.get(0).LastName = 'Ciccarelli2';
		shippingContacts.get(0).Email = 'test@tes.co.uk';
		shippingContacts.get(0).Phone = '1234';



		// When
		Test.startTest();
		B2CSyncRecursiveCheck.alreadyRun = false;
		update shippingContacts.get(0);
		
		Test.stopTest();

		// Then
		Account updatedAccount = [SELECT Shipping_First_Name__c, Shipping_Last_Name__c, 
			Shipping_Email_Address__c, ShippingStreet, ShippingCity,
			ShippingPostalCode, ShippingCountry, Shipping_Phone__c FROM Account WHERE Id = :acc.Id];

		System.assertEquals('Argentina', updatedAccount.ShippingCountry);
		System.assertEquals('A new street', updatedAccount.ShippingStreet);
		System.assertEquals('Adrogue', updatedAccount.ShippingCity);
		System.assertEquals('Javier2', updatedAccount.Shipping_First_Name__c);
		System.assertEquals('Ciccarelli2', updatedAccount.Shipping_Last_Name__c);
		System.assertEquals('test@tes.co.uk', updatedAccount.Shipping_Email_Address__c);
		System.assertEquals('1234', updatedAccount.Shipping_Phone__c);


	}
}