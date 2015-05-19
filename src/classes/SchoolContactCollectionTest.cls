@isTest
private class SchoolContactCollectionTest 
{
	@isTest static void test_method_one() 
	{
		Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Contact; 
		Map<String,Schema.RecordTypeInfo> contactRedcordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
		Id crtId = contactRedcordTypeInfo.get('SD3 School contact').getRecordTypeId();

		Country__c con = new Country__c();
		con.Name = 'ESP';
		con.title__c = 'Spain';
		insert con;

		Organisation__c o = new Organisation__c();
		o.Name = 'test';
		o.Address_1__c = 'test';
		o.Postcode__c = 'W2 4RL';
		o.Country__c = con.Id;
		o.County__c = 'Test';
		o.School_Id__c = 12345;
		insert o;

		Contact c = new Contact();
		c.RecordTypeId = crtId;
		c.FirstName = 'test';
		c.LastName = 'test';
		c.Source__c = 'MSL';
		c.Gen__c = true;
		c.Title__c = 'Headteacher';
		c.Email = 'test@test.com';
		c.SD_ID__c = o.School_Id__c;
		insert c;

		School_contact__c sc = new School_contact__c();
		sc.Contact__c = c.Id;
		sc.Organisation__c = o.Id;
		insert sc;

		Test.startTest();
		PageReference pageRef = new PageReference('/apex/SchoolContactCollection?Id=' + o.Id + '&name=' + o.Name);
		Test.setCurrentPage(pageRef);


		SchoolContactCollection scc= new SchoolContactCollection();
		scc.addContact();
        
        for(SchoolContactCollection.ContactBean cb : scc.contacts)
        {
            cb.lastName = 'Test';
            cb.firstName = 'test';
            cb.gen = false;
        }
        
        scc.savechanges();
		scc.getSalutationValues();
		scc.getSourceValues();
		scc.getTitleValues();
        
		Test.stopTest();


	}
}