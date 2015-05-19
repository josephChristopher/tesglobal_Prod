@isTest
public class OppContactCreationServiceTest {

	public static testMethod void testNullParameters() {
		Boolean failed = false;
		try {
			OpportunityContactCreationService.createOrUpdateBookingContactForOpportunity(null, null);
		} catch (Exception e) {
			failed = true;
		}

		System.assert(failed);

		failed = false;
		try {
			OpportunityContactCreationService.createOrUpdateBookingContactForOpportunity(null, new Contact());
		} catch (Exception e){
				failed = true;
			}

		System.assert(failed);


		failed = false;
		try {
			OpportunityContactCreationService.createOrUpdateBookingContactForOpportunity('12313', null);
		} catch (Exception e) {
				failed = true;
			}

		System.assert(failed);
	}

	public static testMethod void testContactCreatedIfDoesNotExist() {
		Opportunity testOpp = (Opportunity) Reach.SmartFactory.createSObject('Opportunity');
		testOpp.Ad_Number__c = 'AD3D12';
		insert testOpp;

		Contact testContact = new Contact();
		testContact.LastName = 'Last';
		testContact.FirstName = 'First';
		testContact.Email = 'testemail@test.com';

		OpportunityContactCreationService.createOrUpdateBookingContactForOpportunity(testOpp.Ad_Number__c, testContact);

		OpportunityContactRole contactRole = [SELECT Id, Contact.LastName, Contact.FirstName, Contact.Email 
												FROM OpportunityContactRole 
												WHERE Opportunity.Id = :testOpp.Id 
													AND Role = 'Booker' AND Contact.Email = 'testemail@test.com'];

		System.assert(contactRole != null);
		System.assertEquals(testContact.LastName, contactRole.Contact.LastName);
		System.assertEquals(testContact.FirstName, contactRole.Contact.FirstName);
		System.assertEquals(testContact.Email, contactRole.Contact.Email);

	}

	public static testMethod void testContactUpdatedIfExist() {
		Opportunity testOpp = (Opportunity) Reach.SmartFactory.createSObject('Opportunity');
		testOpp.Ad_Number__c = 'AD3D12';
		insert testOpp;
		Contact existingTestContact = (Contact) Reach.SmartFactory.createSObject('Contact');
		existingTestContact.Email = 'testemail@test.com';
		existingTestContact.FirstName = 'OLD';
		existingTestContact.LastName = 'OLD';
		existingTestContact.Created_From_Booking__c = true;

		insert existingTestContact;
		OpportunityContactRole ocr = new OpportunityContactRole(contactId = existingTestContact.Id, opportunityId = testOpp.Id, Role='Booker');
		insert ocr;

		Contact testContact = new Contact();
		testContact.LastName = 'Last';
		testContact.FirstName = 'First';
		testContact.Email = 'testemail@test.com';

		OpportunityContactCreationService.createOrUpdateBookingContactForOpportunity(testOpp.Ad_Number__c, testContact);

		OpportunityContactRole contactRole = [SELECT Id, Contact.LastName, Contact.FirstName, Contact.Email 
												FROM OpportunityContactRole 
												WHERE Opportunity.Id = :testOpp.Id 
													AND Role = 'Booker' AND Contact.Email = 'testemail@test.com'];

		System.assert(contactRole != null);
		System.assertEquals(testContact.LastName, contactRole.Contact.LastName);
		System.assertEquals(testContact.FirstName, contactRole.Contact.FirstName);
		System.assertEquals(testContact.Email, contactRole.Contact.Email);

	}

	public static testMethod void testExistingContactUsedIfMatchesEmail() {
		Opportunity testOpp = (Opportunity) Reach.SmartFactory.createSObject('Opportunity');
		testOpp.Ad_Number__c = 'AD3D12';
		insert testOpp;
		Contact existingTestContact = (Contact) Reach.SmartFactory.createSObject('Contact');
		existingTestContact.Email = 'testemail@test.com';
		existingTestContact.FirstName = 'OLD';
		existingTestContact.LastName = 'OLD';
		insert existingTestContact;

		Contact testContact = new Contact();
		testContact.LastName = 'Last';
		testContact.FirstName = 'First';
		testContact.Email = 'testemail@test.com';

		OpportunityContactCreationService.createOrUpdateBookingContactForOpportunity(testOpp.Ad_Number__c, testContact);

		OpportunityContactRole contactRole = [SELECT Id, Contact.LastName, Contact.FirstName, Contact.Email, ContactId
												FROM OpportunityContactRole 
												WHERE Opportunity.Id = :testOpp.Id 
													AND Role = 'Booker' AND Contact.Email = 'testemail@test.com'];

		System.assert(contactRole != null);
		System.assertEquals(existingTestContact.Id, contactRole.Contactid);

		System.assertEquals(existingTestContact.LastName, contactRole.Contact.LastName);
		System.assertEquals(existingTestContact.FirstName, contactRole.Contact.FirstName);
		System.assertEquals(existingTestContact.Email, contactRole.Contact.Email);

	}




}