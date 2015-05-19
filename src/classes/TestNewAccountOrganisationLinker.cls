@isTest
private class TestNewAccountOrganisationLinker
{
	@isTest static void InsertAnAccountWithSchoolId()
	{
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

		// Insert the Account record.
		Account acc = new Account(Name = 'Test Account',
		                          Client_Type__c = 'To Be Analysed',
		                          Customer_Group__c = 'Academy',
		                          Street__c = '29 Darling',
		                          City_Town__c = 'Boston',
		                          Country__c = 'UGANDA',
		                          Post_Code__c = '312312',
		                          Phone = '123231231',
		                          Main_Email__c = 'dsadsa@dsadsa.com',
		                          Region_1__c = 'Classified',
		                          Region_2__c = 'United Kingdom',
		                          Not_Approved_by_Finance__c = false,
		                          School_ID__c = 12345);

		Test.startTest();
		insert acc;
		Test.stopTest();
	}

	@isTest static void UpdateAnAccountWithSchoolId1()
	{
		Country__c con = new Country__c();
		con.Name = 'ESP';
		con.title__c = 'Spain';
		insert con;

		Organisation__c o1 = new Organisation__c();
		o1.Name = 'test';
		o1.Address_1__c = 'test';
		o1.Postcode__c = 'W2 4RL';
		o1.Country__c = con.Id;
		o1.County__c = 'Test';
		o1.School_Id__c = 1234;
		insert o1;

		Organisation__c o2 = new Organisation__c();
		o2.Name = 'test';
		o2.Address_1__c = 'test';
		o2.Postcode__c = 'W2 4RL';
		o2.Country__c = con.Id;
		o2.County__c = 'Test';
		o2.School_Id__c = 12345;
		insert o2;

		// Insert the Account record.
		Account acc = new Account(Name = 'Test Account',
		                          Client_Type__c = 'To Be Analysed',
		                          Customer_Group__c = 'Academy',
		                          Street__c = '29 Darling',
		                          City_Town__c = 'Boston',
		                          Country__c = 'UGANDA',
		                          Post_Code__c = '312312',
		                          Phone = '123231231',
		                          Main_Email__c = 'dsadsa@dsadsa.com',
		                          Region_1__c = 'Classified',
		                          Region_2__c = 'United Kingdom',
		                          Not_Approved_by_Finance__c = false,
		                          School_ID__c = 1234);

		insert acc;

		Test.startTest();
		acc.School_ID__c = 12345;
		update acc;
		Test.stopTest();
	}

	@isTest static void UpdateAnAccountWithoutSchoolid()
	{
		Country__c con = new Country__c();
		con.Name = 'ESP';
		con.title__c = 'Spain';
		insert con;

		Organisation__c o1 = new Organisation__c();
		o1.Name = 'test';
		o1.Address_1__c = 'test';
		o1.Postcode__c = 'W2 4RL';
		o1.Country__c = con.Id;
		o1.County__c = 'Test';
		o1.School_Id__c = 1234;
		insert o1;

		// Insert the Account record.
		Account acc = new Account(Name = 'Test Account',
		                          Client_Type__c = 'To Be Analysed',
		                          Customer_Group__c = 'Academy',
		                          Street__c = '29 Darling',
		                          City_Town__c = 'Boston',
		                          Country__c = 'UGANDA',
		                          Post_Code__c = '312312',
		                          Phone = '123231231',
		                          Main_Email__c = 'dsadsa@dsadsa.com',
		                          Region_1__c = 'Classified',
		                          Region_2__c = 'United Kingdom',
		                          Not_Approved_by_Finance__c = false,
		                          School_ID__c = 1234);

		insert acc;

		Test.startTest();
		acc.School_ID__c = null;
		update acc;
		Test.stopTest();
	}


	@isTest static void UpdateAnAccountWithSchoolid2()
	{
		Country__c con = new Country__c();
		con.Name = 'ESP';
		con.title__c = 'Spain';
		insert con;

		Organisation__c o1 = new Organisation__c();
		o1.Name = 'test';
		o1.Address_1__c = 'test';
		o1.Postcode__c = 'W2 4RL';
		o1.Country__c = con.Id;
		o1.County__c = 'Test';
		o1.School_Id__c = 12345;
		insert o1;

		// Insert the Account record.
		Account acc = new Account(Name = 'Test Account',
		                          Client_Type__c = 'To Be Analysed',
		                          Customer_Group__c = 'Academy',
		                          Street__c = '29 Darling',
		                          City_Town__c = 'Boston',
		                          Country__c = 'UGANDA',
		                          Post_Code__c = '312312',
		                          Phone = '123231231',
		                          Main_Email__c = 'dsadsa@dsadsa.com',
		                          Region_1__c = 'Classified',
		                          Region_2__c = 'United Kingdom',
		                          Not_Approved_by_Finance__c = false,
		                          School_ID__c = 1234);

		insert acc;

		Test.startTest();
		acc.School_ID__c = 12345;
		update acc;
		Test.stopTest();
	}

}