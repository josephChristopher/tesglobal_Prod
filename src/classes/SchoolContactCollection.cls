/*
	CDA
*/
public with sharing class SchoolContactCollection
{
	public String orgName	{get; set;}
	public List<ContactBean> contacts {get; set;}
	private Id orgId;

	public SchoolContactCollection()
	{
		Id orgId = ApexPages.currentPage().getParameters().get('Id');
		String name = ApexPages.currentPage().getParameters().get('name');

		if (orgId != null)
		{
			List<School_contact__c> sclist = [SELECT Id, Name, Contact__r.Salutation, Contact__r.Title__c, Contact__r.FirstName, Contact__r.LastName, Contact__r.Source__c, Contact__r.Gen__c, Contact__r.Email, Contact__r.Comments__c, Contact__c, Organisation__r.Name  FROM School_contact__c WHERE Organisation__c = :orgId];
			this.orgName = name;
			this.orgId = orgId;
			this.getAllContacts(sclist);
			System.debug('sclist: ' + sclist);
		}
	}

	private void getAllContacts(List<School_contact__c> sclist)
	{
		List<ContactBean> contactlist = new List<ContactBean>();
		for (School_contact__c sc : sclist)
		{
			ContactBean c = getContactBeanFromSchoolContact(sc);
			contactlist.add(c);
		}

		if (contactlist.size() > 0)
			this.contacts = contactlist;
		else
			this.addContact();
	}

	private ContactBean getContactBeanFromSchoolContact(School_contact__c sc)
	{
		ContactBean cb = new ContactBean();
		cb.id = sc.Contact__c;
		cb.salutation = sc.Contact__r.Salutation;
		cb.firstName = sc.Contact__r.FirstName;
		cb.lastName = sc.Contact__r.LastName;
		cb.source = sc.Contact__r.Source__c;
		cb.title = sc.Contact__r.Title__c;
		cb.gen = sc.Contact__r.Gen__c;
		cb.email = sc.Contact__r.Email;
		cb.comments = sc.Contact__r.Comments__c;
		cb.sc_name = sc.Name;

		return cb;
	}

	private Contact getContactFromContactBean(ContactBean cb)
	{
		Contact c = new Contact();
		c.Id = cb.id;
		c.Salutation = cb.salutation;
		c.FirstName = cb.firstName;
		c.LastName = cb.lastName;
		c.Source__c = cb.source;
		c.Title__c = cb.title;
		c.Gen__c = cb.gen ;
		c.Email = cb.email;
		c.Comments__c = cb.comments;

		return c;
	}

	public List<SelectOption> getSourceValues()
	{
		List<SelectOption> options = new List<SelectOption>();

		Schema.DescribeFieldResult fieldResult = Contact.Source__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

		for (Schema.PicklistEntry f : ple)
		{
			options.add(new SelectOption(f.getLabel(), f.getValue()));
		}

		return options;
	}

	public List<SelectOption> getSalutationValues()
	{
		List<SelectOption> options = new List<SelectOption>();

		Schema.DescribeFieldResult fieldResult = Contact.Salutation.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

		for (Schema.PicklistEntry f : ple)
		{
			options.add(new SelectOption(f.getLabel(), f.getValue()));
		}

		return options;
	}

	public List<SelectOption> getTitleValues()
	{
		List<SelectOption> options = new List<SelectOption>();

		Schema.DescribeFieldResult fieldResult = Contact.Title__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

		for (Schema.PicklistEntry f : ple)
		{
			options.add(new SelectOption(f.getLabel(), f.getValue()));
		}

		return options;
	}

	public void addContact()
	{
		if (contacts == null)
			contacts = new List<ContactBean>();
		ContactBean c = new ContactBean();
		c.sc_name = 'New';
		contacts.add(c);
	}

	public PageReference savechanges()
	{
		List<Contact> contactsToUpdate = new List<Contact>();
		List<Contact> contactsToInsert = new List<Contact>();
		for (ContactBean cb : contacts)
		{
			Contact c = this.getContactFromContactBean(cb);
			if (c.Id == null)
			{
				c.RecordTypeId = Schema.getGlobalDescribe().get('Contact').getDescribe().getRecordTypeInfosByName().get('SD3 School contact').getRecordTypeId();
				contactsToInsert.add(c);
			}
			else
			{
				contactsToUpdate.add(c);
			}
		}

		update contactsToUpdate;

		if (contactsToInsert.size() > 0)
		{
			insert contactsToInsert;
			List<School_contact__c> scToInsert = new List<School_contact__c>();
			for (Contact c : contactsToInsert)
			{
				School_contact__c sc = new School_contact__c();
				sc.Contact__c = c.Id;
				sc.Organisation__c = orgId;
				scToInsert.add(sc);
			}

			insert scToInsert;
		}

		return new PageReference('/' + orgId);
	}


	public class ContactBean
	{
		public Id id {get; set;}
		public String salutation {get; set;}
		public String lastName {get; set;}
		public String firstName {get; set;}
		public String source {get; set;}
		public String comments {get; set;}
		public String title {get; set;}
		public Boolean gen {get; set;}
		public String email {get; set;}
		public String sc_name {get; set;}
	}

}