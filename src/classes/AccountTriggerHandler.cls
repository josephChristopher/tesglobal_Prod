public class AccountTriggerHandler extends Reach.TriggerHandlerFactory 
{
	
	public override void afterInsert() 
	{

		List<Account> accsForFindOrganisationBySchoolIdv = new List<Account>();
		Set<Decimal> schoolIds = new Set<Decimal>(); 
		for(Account a : (List<Account>)Trigger.new)
		{
			// If the Account has the School Id filled
			if(a.School_Id__c != null)
			{
				accsForFindOrganisationBySchoolIdv.add(a);
				schoolIds.add(a.School_Id__c);
			}
		}

		searchAndLinkVacanciesWithSameSchoolId();
		searchAndLinkOrganisationsWithAccountsBySchoolId(accsForFindOrganisationBySchoolIdv,schoolIds);
	}

	public override void afterUpdate() 
	{
		List<Account> accsForFindOrganisationBySchoolIdv = new List<Account>();
		Set<Decimal> schoolIds = new Set<Decimal>(); 
		Set<Id> accIds = new Set<Id>();

		for(Account a : (List<Account>)Trigger.new)
		{
			// If the Account has the School Id filled and the value has changed
			if(((Account)Trigger.oldMap.get(a.Id)).School_Id__c != a.School_Id__c)
			{
				schoolIds.add(a.School_Id__c);
				accIds.add(a.Id);
				accsForFindOrganisationBySchoolIdv.add(a);
			}
		}

		searchAndUpdateOrganisationsWithAccountsBySchoolId(schoolIds,accIds, accsForFindOrganisationBySchoolIdv);
	}
	
	private void searchAndLinkVacanciesWithSameSchoolId() {
		new NewAccountVacancyLinker((List<Account>) Trigger.new).linkVacanciesAndContacts();
	}

	private void searchAndLinkOrganisationsWithAccountsBySchoolId(List<Account> accs, Set<Decimal> schoolIds) 
	{
		if(accs.size()>0 && schoolIds.size()>0)
				new NewAccountOrganisationLinker(schoolIds, accs).createAccountOrganisationRecords();
	}

	private void searchAndUpdateOrganisationsWithAccountsBySchoolId(Set<Decimal> schoolIds, Set<Id> accIds, List<Account> accs) 
	{
		if(accIds.size()>0 && schoolIds.size()>0)
				new NewAccountOrganisationLinker(schoolIds, accIds, accs).updateAccountOrganisationRecords();
	}
}