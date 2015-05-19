/*
*	Author: Carlos Dobarco
*	Date:	10/03/2015
*	Descripcion: Create or Update a AccountOrganizacion record each time the account's school id is filled
*/
public with sharing class NewAccountOrganisationLinker
{
	private List<Account> accs;
	private List<Organisation__c> orgs;
	private List<AccountOrganisation__c> accorgs;

	public NewAccountOrganisationLinker(Set<Decimal> schoolIds, List<Account> accs)
	{
		this.accs = accs;
		orgs = this.queryOrganisitionsBySchoolId(schoolIds);
	}

	public NewAccountOrganisationLinker(Set<Decimal> schoolIds, Set<Id> accIds, List<Account> accs)
	{
		this.accs = accs;
		orgs = this.queryOrganisitionsBySchoolId(schoolIds);
		accorgs = this.queryAccountOrganisationsByAccountId(accIds);
	}

	private List<Organisation__c> queryOrganisitionsBySchoolId(Set<Decimal> accSchoolIds)
	{
		return [SELECT Id, School_Id__c
		        FROM Organisation__c
		        WHERE School_Id__c IN :accSchoolIds];

	}

	private List<AccountOrganisation__c> queryAccountOrganisationsByAccountId(Set<Id> accIds)
	{
		return [SELECT Id, Organisation__c, Account__r.School_Id__c
		        FROM AccountOrganisation__c
		        WHERE Account__c IN :accIds];

	}

	public void updateAccountOrganisationRecords()
	{
		if (accorgs.size() > 0)
		{
			Map<Decimal, Organisation__c> orgsMap = new Map<Decimal, Organisation__c>();
			for (Organisation__c o : orgs)
				orgsMap.put(o.School_Id__c, o);

			List<AccountOrganisation__c> aostoUpdate = new List<AccountOrganisation__c>();
			List<AccountOrganisation__c> aostoDelete = new List<AccountOrganisation__c>();

			for (AccountOrganisation__c ao : accorgs)
			{
				System.debug('[NewAccountOrganisationLinker][CDA] ao.Account__r.School_Id__c: ' + ao.Account__r.School_Id__c);
				if (orgsMap.containsKey(ao.Account__r.School_Id__c))
				{
					ao.Organisation__c = orgsMap.get(ao.Account__r.School_Id__c).Id;
					aostoUpdate.add(ao);
				}
				else
				{
					aostoDelete.add(ao);
				}
			}

			try
			{
				if (aostoUpdate.size() > 0)
					update aostoUpdate;

				if (aostoDelete.size() > 0)
					delete aostoDelete;
			}
			catch (Exception e)
			{
				Reach.Utils.CreateSystemException(e);
			}


		}
		else if (accorgs.size() == 0 && orgs.size() > 0)
		{
			this.createAccountOrganisationRecords();
		}
	}

	public void createAccountOrganisationRecords()
	{
		if (orgs.size() > 0)
		{
			Map<Decimal, Organisation__c> orgsMap = new Map<Decimal, Organisation__c>();
			for (Organisation__c o : orgs)
				orgsMap.put(o.School_Id__c, o);


			List<AccountOrganisation__c> aostoinsert = new List<AccountOrganisation__c>();
			for (Account a : accs)
			{
				if (orgsMap.containsKey(a.School_Id__c))
				{
					AccountOrganisation__c ao = new AccountOrganisation__c();
					ao.Account__c = a.Id;
					ao.Organisation__c = orgsMap.get(a.School_Id__c).Id;

					aostoinsert.add(ao);
				}
			}

			try
			{
				if (aostoinsert.size() > 0)
					insert aostoinsert;
			}
			catch (Exception e)
			{
				Reach.Utils.CreateSystemException(e);
			}

		}
	}
}