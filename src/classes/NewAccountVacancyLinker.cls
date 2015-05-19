/**
 * Linker class for processing a list of new accounts Accounts and linking orphan vacancies.
 */
public with sharing class NewAccountVacancyLinker {
	
	private Map<Double, Account> accountsBySchoolId;
	private List<Vacancy__c> vacanciesThatMatch;
	
   /**
	* Creates the object based on the given accounts.
	* Maps and gathers all the data needed for the procesing.
	*/
	public NewAccountVacancyLinker(List<Account> updatedAccounts) {
				System.debug('Updated Accounts ' + updatedAccounts);
		
		this.accountsBySchoolId = mapAccountsBySchoolId(updatedAccounts);
		this.vacanciesThatMatch = queryAllVacanciesForSchoolIds(
			accountsBySchoolId.keySet());
		System.debug('The following vacancies match the schoolId (' + updatedAccounts + '): '  + vacanciesThatMatch);
			
	}
   
   /**
	* For all vacancies that match the account's schoolId we set:
	* vacancy->account = the new account
	* vacancy->Sales Form->Recruitment Owner->Account = the new account
	*/	
	public void linkVacanciesAndContacts() {
		linkToVacanciesWithSameSchoolId();
		linkToContactsFromThoseVacancyForms();
	}
	
	private void linkToVacanciesWithSameSchoolId() {
		for (Vacancy__c vacancy : vacanciesThatMatch) {
			Account accToMatch = accountsBySchoolId.get(
				vacancy.Vacancy_Employer__c);
			vacancy.Account__c = accToMatch.Id;
		}
		update vacanciesThatMatch;
	}
	
	private Map<Double, Account> mapAccountsBySchoolId(List<Account> accounts) {
		Map<Double, Account> result = new Map<Double, Account>();
		
		for (Account acc : accounts) {
			result.put(acc.School_Id__c, acc);
		}
		
		return result;
	}
	
	private void linkToContactsFromThoseVacancyForms() {
		
		List<Contact> contactsToUpdateAccount = new List<Contact>();
		for (Vacancy__c vacancy : vacanciesThatMatch) {
			Account accToMatch = accountsBySchoolId.get(vacancy.Vacancy_Employer__c);
			
			if (hasSalesForm(vacancy) && hasRecruitmentOwner(vacancy.Sales_Form__r)) {
				System.debug('Contact to update = ' +  vacancy.Sales_Form__r.Recruitment_Owner__c);
				
				Contact updatedContact = new Contact(
										Id = vacancy.Sales_Form__r.Recruitment_Owner__c,
										accountId = accToMatch.Id);
										
				contactsToUpdateAccount.add(updatedContact);
			}
		}
		
		update contactsToUpdateAccount;
	}
	
	private List<Vacancy__c> queryAllVacanciesForSchoolIds(Set<Double> schoolIds) {
		return [SELECT 
					id, 
					Vacancy_Employer__c, 
					Account__c,
					Sales_Form__r.Recruitment_Owner__r.AccountId
				FROM Vacancy__c
				WHERE Account__c = NULL
				AND Vacancy_Employer__c != NULL
				AND Vacancy_Employer__c IN :schoolIds];
	}
	
	private Boolean hasSalesForm(Vacancy__c vacancy) {
		return vacancy.Sales_Form__r != null;
	}
	
	private Boolean hasRecruitmentOwner(Sales_Form__c salesForm) {
		return salesForm.Recruitment_Owner__c != null;
	}

}