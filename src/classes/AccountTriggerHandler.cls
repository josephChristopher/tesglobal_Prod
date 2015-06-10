public class AccountTriggerHandler extends Reach.TriggerHandlerFactory {
	
    public override void beforeInsert() {
        System.debug('Before Insert');
       updateFinancialForceFieldsFromMslOnes();
    }
    
    public override void beforeUpdate() {
        System.debug('Before Update');

      updateFinancialForceFieldsFromMslOnes();
    }
    
	public override void afterInsert() 
	{
        System.debug('After Insert');

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
        createB2CContacts();

        //searchAndLinkwithSameMSLId();
	}

	public override void afterUpdate() 
	{
        System.debug('After update');

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
		updateB2CContacts();
	}
    
    private void updateFinancialForceFieldsFromMslOnes() {
    	//new FinancialForceAccountSetter((Map<Id, Account>) Trigger.oldMap, (List<Account>) Trigger.new).updateFields();
    }
    
    private void createB2CContacts() {
       new B2CContactsCreator((List<Account>) Trigger.new).createContacts();
    }
    
    private void updateB2CContacts() {
    	if (!B2CSyncRecursiveCheck.hasSyncAlreadyRun())
      		new B2CContactsCreator((List<Account>) Trigger.new).updateContacts();
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
    
    /*private void searchAndLinkwithSameMSLId() {
        new NewAccountCreationRequestLinker((List<Account>) Trigger.new).linkNewAccounttoSalesRequests();
        new NewAccountCreationRequestLinker((List<Account>) Trigger.new).linkNewAccounttoOpportunities();
        new NewAccountCreationRequestLinker((List<Account>) Trigger.new).linkNewAccounttoOrders();
    }*/
}