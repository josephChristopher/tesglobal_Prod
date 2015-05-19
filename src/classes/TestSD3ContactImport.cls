@isTest
private class TestSD3ContactImport {
	
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

		List<Contact> contacts = new List<Contact>();

		for(Integer i=0;i<200;i++)
		{
			Contact c = new Contact();
			c.RecordTypeId = crtId;
			c.FirstName = 'test' + i;
			c.LastName = 'test' + i;
			c.Source__c = 'MSL' + i;
			c.Gen__c = true;
			c.Title__c = 'Headteacher' + i;
			c.Email = 'test@test.com' + i;
			c.SD_ID__c = o.School_Id__c;
			contacts.add(c);
		}
		
		Test.startTest();
		insert contacts;
		Test.stopTest();
	}
	
}