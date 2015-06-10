@isTest
private class TestB2CContactsCreator {
	@isTest
	static void itShouldCreateBillingContactWhenB2CAccountIsCreated() {
		
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
			BillingCountry = 'United Kingdom');

		// When
		insert acc;

		// Then
		List<Contact> primaryContacts = [SELECT FirstName, LastName, RecordTypeId, Email, MailingStreet, MailingCity, MailingPostalCode, MailingCountry 
											FROM Contact 
											WHERE AccountId = :acc.Id 
												AND Type__c = 'Primary'];

		System.assert(primaryContacts != null);
		System.assertEquals(1, primaryContacts.size());
		System.assertEquals(acc.Billing_First_Name__c, primaryContacts.get(0).FirstName);
		System.assertEquals(acc.Billing_Last_Name__c, primaryContacts.get(0).LastName);
		System.assertEquals(acc.Billing_Email_Address__c, primaryContacts.get(0).Email);
		System.assertEquals(contRecTypeId, primaryContacts.get(0).RecordTypeId);

		System.assertEquals(acc.BillingStreet, primaryContacts.get(0).MailingStreet);
		System.assertEquals(acc.BillingCity, primaryContacts.get(0).MailingCity);
		System.assertEquals(acc.BillingPostalCode, primaryContacts.get(0).MailingPostalCode);
		System.assertEquals(acc.BillingCountry, primaryContacts.get(0).MailingCountry);

		List<Contact> shippingContacts = [SELECT FirstName, LastName, RecordTypeId, Email, MailingStreet, MailingCity, MailingPostalCode, MailingCountry 
											FROM Contact 
											WHERE AccountId = :acc.Id 
												AND Type__c = 'Shipping'];
		System.assert(shippingContacts != null);
		System.assertEquals(0, shippingContacts.size());


	}

	@isTest
	static void itShouldCreateBillingAndShippingContactWhenB2CAccountIsCreated() {
		
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
			Shipping_First_Name__c = 'Javier', 
			Shipping_Last_Name__c = 'Ciccarelli', 
			Shipping_Email_Address__c = 'test.email@cloudreach.co.uk',
			ShippingStreet = 'Another street',
			ShippingCity = 'Shipping Cuty',
			ShippingPostalCode = 'NW1 NW1',
			ShippingCountry = 'United Kingdom');

		// When
		insert acc;

		// Then
		List<Contact> primaryContacts = [SELECT FirstName, LastName, RecordTypeId, Email, MailingStreet, MailingCity, MailingPostalCode, MailingCountry 
											FROM Contact 
											WHERE AccountId = :acc.Id 
												AND Type__c = 'Primary'];

		System.assert(primaryContacts != null);
		System.assertEquals(1, primaryContacts.size());
		System.assertEquals(acc.Billing_First_Name__c, primaryContacts.get(0).FirstName);
		System.assertEquals(acc.Billing_Last_Name__c, primaryContacts.get(0).LastName);
		System.assertEquals(acc.Billing_Email_Address__c, primaryContacts.get(0).Email);
		System.assertEquals(contRecTypeId, primaryContacts.get(0).RecordTypeId);

		System.assertEquals(acc.BillingStreet, primaryContacts.get(0).MailingStreet);
		System.assertEquals(acc.BillingCity, primaryContacts.get(0).MailingCity);
		System.assertEquals(acc.BillingPostalCode, primaryContacts.get(0).MailingPostalCode);
		System.assertEquals(acc.BillingCountry, primaryContacts.get(0).MailingCountry);

		List<Contact> shippingContacts = [SELECT FirstName, LastName, RecordTypeId, Email, MailingStreet, MailingCity, MailingPostalCode, MailingCountry 
											FROM Contact 
											WHERE AccountId = :acc.Id 
												AND Type__c = 'Shipping'];
		System.assert(shippingContacts != null);
		System.assertEquals(1, shippingContacts.size());
		System.assertEquals('[Shipping] ' + acc.Billing_First_Name__c, shippingContacts.get(0).FirstName);
		System.assertEquals(acc.Billing_Last_Name__c, shippingContacts.get(0).LastName);
		System.assertEquals(acc.Billing_Email_Address__c, shippingContacts.get(0).Email);
		System.assertEquals(contRecTypeId, shippingContacts.get(0).RecordTypeId);

		System.assertEquals(acc.ShippingStreet, shippingContacts.get(0).MailingStreet);
		System.assertEquals(acc.ShippingCity, shippingContacts.get(0).MailingCity);
		System.assertEquals(acc.ShippingPostalCode, shippingContacts.get(0).MailingPostalCode);
		System.assertEquals(acc.ShippingCountry, shippingContacts.get(0).MailingCountry);


	}
}