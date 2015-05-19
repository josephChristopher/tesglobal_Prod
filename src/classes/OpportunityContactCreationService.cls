@RestResource(urlMapping='/OpportunityContact/*')
global class OpportunityContactCreationService {

	private static final String NEW_CONTACT_ROLE_TYPE = 'Booker';

	global class OpportunityContactException extends Exception {}


	@HttpPost
	global static String createOrUpdateBookingContactForOpportunity(String oppMslId, Contact cont) {

		String email = cont.Email;

		if (oppMslId == null || cont == null)
			throw new OpportunityContactException('Wrong request, the oppId or the contact was null');

		List<OpportunityContactRole> aContactRole = [SELECT ContactId, Contact.Created_From_Booking__c 
                                                     		FROM OpportunityContactRole 
                                                     		WHERE Opportunity.Ad_Number__c = :oppMslId 
                                                     			AND role = :NEW_CONTACT_ROLE_TYPE 
                                                     			AND Contact.Email = :email];
        
        if (aContactRole == null || aContactRole.isEmpty()) {

        	List<Contact> exisitingContactWithSameEmail = Database.query(
				new Reach.QueryFactory(Contact.SObjectType)
					.selectField(Contact.Id)
					.setCondition('Email = :email')
					.toSOQL()
				);

        	Id contactId = null;

        	if (exisitingContactWithSameEmail == null || exisitingContactWithSameEmail.isEmpty()) {
                 cont.Created_From_Booking__c = true;
        		 insert cont;
        		 contactId = cont.Id;
        	} else {
        		contactid = exisitingContactWithSameEmail[0].Id;
        	}

        	List<Opportunity> opps = Database.query(
				new Reach.QueryFactory(Opportunity.SObjectType)
					.selectField(Opportunity.Id)
					.setCondition('Ad_Number__c = :oppMslId')
					.toSOQL()
				);

        	if (opps == null || opps.isEmpty() || opps.size() > 1)
        		throw new OpportunityContactException('Only found ' + opps + ' as opportunity with the given MSL Id');


        	OpportunityContactRole contactRole = new OpportunityContactRole(role=NEW_CONTACT_ROLE_TYPE, opportunityId=opps[0].Id, contactId=contactId);
        	insert contactRole;
        	return 'New contact inserted';
         }

         if (aContactRole.size() > 1)
         	return 'Many existing contacts. Nothing done.';

          if (!aContactRole[0].Contact.Created_From_Booking__c)
          	return 'The relationship is already in place with another contact. Do nothing.';

          Contact c = new Contact(Id = aContactRole[0].contactId);
          c.LastName = cont.LastName;
          c.FirstName = cont.FirstName;
          c.Account = cont.Account;
          c.Email = cont.Email;

      	  update c;

          return 'Existing contact updated';    
	  }


}