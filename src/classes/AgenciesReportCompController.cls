public class AgenciesReportCompController {

	private Boolean initialised = false;

	public Id accountId {get;
		set {
			if (value == null)
				return;
			accountId = value;
			initialiseReport();
		}
	}

	public Id contactId { get;
		set {
			if (value == null)
				return;
			contactId = value;
			initialiseReport();
		}
	}

	public List<AdStatsReport> reportLines {get;set;}

	private void initialiseReport() {
		//System.debug('accountId: ' + accountId + ' contactId: ' + contactId);
		if (initialised || accountId == null || contactId == null)
			return;

		this.initialised = true;

		List<OpportunityContactRole> contactRoles = [SELECT OpportunityId, Contact.Name 
        												FROM OpportunityContactRole 
        												WHERE Role = 'Booker' 
        													AND ContactId = :contactId
        													 AND Contact.AccountId = :accountId];

        System.debug('Contact roles: ' + contactRoles);

        Map<Object, SObject> contactRoleByOppId = Reach.Utils.collect(contactRoles)
        											.byField(OpportunityContactRole.OpportunityId)
        											.noDuplicates();

        Set<Id> ids = new Set<Id>();
	    for (Object oppId : contactRoleByOppId.keySet())
	        ids.add((Id) oppId);

	    Date filterDate = Date.today().addDays(-7);
	    //filterDate;

        List<Vacancy__c> vcs = [Select Name, Account__c, Date_of_Ad_Publication_on_TES_Site__c, 
	        Date_of_Ad_Expiry_on_TES_Global_Site__c, Ad_Number__c, 
	        Booking__r.Account.Name, Booking__r.Name, Account__r.Name,
	    	(Select Date__c, Job_Views__c, Job_Apply_Clicks__c From Ad_Web_Performance_Data__r WHERE Date__c > :filterDate ORDER BY Date__c DESC)
	   		From Vacancy__c WHERE 
	   			Booking__c IN :ids
	   			AND ID IN (SELECT vacancy__c FROM Ad_Web_Performance__c WHERE Date__c > :filterDate)
	   		];

	   	        System.debug('Vacancies: ' + vcs);

       // List<SObject> filteredVacancies = filterVacanciesThatDontHavePerformanceData

                    

        reportLines = new List<AdStatsReport>();
        for (Vacancy__c vacancy : vcs) {

            AdStatsReport reportLine = new AdStatsReport();
            reportLine.vacancy = vacancy;

            OpportunityContactRole role  = (OpportunityContactRole) contactRoleByOppId.get(vacancy.Booking__c);
            reportLine.contactRole = role;
            reportLines.add(reportLine);
        }


	}

	public class AdStatsReport {
	    public  Vacancy__c vacancy {get; set;}
	    public  OpportunityContactRole contactRole {get; set;}
	}

}