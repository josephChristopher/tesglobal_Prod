global with sharing class CustomerSuccessSurveyController {
    
    public class Metrics {
        public String name {get; set;} 
        public String title {get; set;}
        public String questionFormat {get; set;}
        public List<String> values {get; set;}
    }
    
    private ApexPages.StandardController  stdController = null;
    
    public String surveyId { get; set; }
    public String surveyTitle { get; set; }
    public List<Metrics> surveyMetrics { get; set; }
    public List<Survey_Template__c> templateList { get; set; }
    public boolean metricsReady { get; set; }
    public List<Vacancy_Contact__c> vContactList {get; set; }
    public String vacancyContactId {get; set;}
    public String response {get;set;}
    public String blockStyle {get; set;}
    public Boolean showOtherButtons {get; set;}
   
    
    public Case surveyCase;
    
    public CustomerSuccessSurveyController(ApexPages.StandardController  ctl) {
       this.stdController = ctl;
       this.surveyTitle = 'TES Customer Success Survey'; 
       this.metricsReady = false;
       this.showOtherButtons = true;
       if(this.stdController != null) { 
            this.surveyCase = (Case)this.stdController.getRecord();
       }
       if(ApexPages.currentPage() != null) {
           if(ApexPages.currentPage().getParameters().get('survey') != null && ApexPages.currentPage().getParameters().get('contact') != null) {
                surveyId = ApexPages.currentPage().getParameters().get('survey');
                vacancyContactId = ApexPages.currentPage().getParameters().get('contact');
           }
       }
        if(surveyId != null && vacancyContactId != null) {
            metricsReady = true;
            Survey_Template__c template = getTemplateById(surveyId);
            surveyTitle = template.Name;
            populateSurveyMetrics();
            blockStyle = 'display: none;';
            this.showOtherButtons = false;
        } 
    }
    
    public List<Survey_Template__c> listTemplates() {
        if(templateList == null) {
            templateList = [Select Id,Name from Survey_Template__c order by Name DESC];
        }
        
        return templateList;
    }
    
    
    public List<SelectOption> getTemplatesAsOptions() {
        List<SelectOption> optionList = new List<SelectOption>();
        for(Survey_Template__c srv : listTemplates()) {
            optionList.add(new SelectOption(srv.Id,srv.Name));
        }
        
        return optionList;
    }
    
    public List<String> parseValues(String valueList) {
        if(valueList != null) {
            return valueList.split('\n');
        }
        
        return null;
    }
    
    public Survey_Template__c getTemplateById(String id) {
        for(Survey_Template__c srv : listTemplates()) {
            if(srv.Id == id) {
                return srv;
            }
        }
        
        return null;
    }
    
    public List<Survey_Metrics__c> getMetricsForSurvey(Id surveyId) {
        return [Select Id,Name, Order__c, Metrics__r.Id,Metrics__r.Name,Metrics__r.Question__c,Metrics__r.Question_Format__c,Metrics__r.Available_Values__c from Survey_Metrics__c 
                            where Survey_Template__r.Id = :surveyId ORDER BY Order__c ASC];
    }
    
    public void populateSurveyMetrics() {
        if(surveyId != null) {
            //find the title of the survey from it's id
            Survey_Template__c srv = getTemplateById(surveyId);
            if(srv != null) {
                surveyTitle = srv.Name;
            }
            surveyMetrics = new List<Metrics>();
            for(Survey_Metrics__c srvMetric : getMetricsForSurvey(surveyId)) {
                metricsReady = true;
                Metrics mtr = new Metrics();
                mtr.name = srvMetric.Name;
                mtr.title = srvMetric.Metrics__r.Question__c;
                mtr.questionFormat = srvMetric.Metrics__r.Question_Format__c;
                mtr.values = parseValues(srvMetric.Metrics__r.Available_Values__c);
                surveyMetrics.add(mtr);
            }
        }
    }
    
    public List<Vacancy_Contact__c> listVacancyContacts() {
        return listVacancyContacts(this.surveyCase.Id);
    }
     
    public List<Vacancy_Contact__c> listVacancyContacts(String caseId) {
        if(vContactList == null) {
            vContactList = static_listVacancyContacts(caseId);
        }
        
        return vContactList;
    }
    
    global static List<Vacancy_Contact__c> static_listVacancyContacts(String caseId) {
    	Case thisSurveyCase = [Select Id, Vacancy__c From Case where Id =: caseId];
    	return [Select Id, Contact__c, Vacancy__c, Contact__r.LastName, Contact__r.FirstName, Contact__r.Email from Vacancy_Contact__c
                           where Vacancy__c =: thisSurveyCase.Vacancy__c 
                           ];
    }
    
    public List<SelectOption> getVacancyContacts() {
        List<SelectOption> vacancyContactList = new List<SelectOption>();
        for(Vacancy_Contact__c vc : static_listVacancyContacts(this.surveyCase.Id)) {
            vacancyContactList.add(new SelectOption(vc.Contact__c, vc.Contact__r.FirstName + ' ' + vc.Contact__r.LastName + ' (' + vc.Contact__r.Email + ')'));
        }
        
        return vacancyContactList;
    }
    
    
    global static Vacancy_Contact__c getVacancyContactById(String id,String caseId) {
        for(Vacancy_Contact__c vc : CustomerSuccessSurveyController.static_listVacancyContacts(caseId)) {
            if(vc.Contact__c == id) {
                return vc;
            }
        }
        
        return null;
    }
    
    public List<Vacancy_Contact__c> getVacancyContactForSurvey(Id vacancyContactId) {
        return [Select Id, Contact__c, Vacancy__c, Contact__r.LastName, Contact__r.FirstName, Contact__r.Email from Vacancy_Contact__c
                           where Contact__c =: vacancyContactId];
    }
    
    public PageReference doCancel() {
        PageReference casePage = new PageReference('/'+ surveyCase.Id);
            casePage.setRedirect(true);
            return casePage;
    }
    
    
 
    public boolean displayPopup {get; set;}
 
    public void closePopup() {
        displayPopup = false;
    }
 
    public void showPopup() {
        displayPopup = true;
    }
    
    public boolean displayHelpPopup {get;set;}
    
    public void closeHelpPopup() {
        displayHelpPopup = false;
    }
 
    public void showHelpPopup() {
        displayHelpPopup = true;
    }
  

    
    
    public class KeyPairContainer {
        List<KeyPair> values { get; set; }
    }
    
    public class KeyPair {
        public String key { get; set; }
        public String value { get; set; }
    }

    
    /*public PageReference sendEmail(){ 
     
      Messaging.SingleEmailMessage surveyEmail = new Messaging.SingleEmailMessage();
                                             
        surveyEmail.setTargetObjectId('003m0000006YsaR');
        //surveyEmail.setTargetObjectId(vc.Contact__c);
        surveyEmail.setWhatId('a0Gm0000000Agon');
        //surveyEmail.setWhatId(surveyId);
        surveyEmail.setorgWideEmailAddressId('0D2m000000000Jm');
        surveyEmail.setTemplateId('00Xm0000000M7oN');
        surveyEmail.setSaveAsActivity(True);
                                             
       
        try{
            Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {surveyEmail});
            if(resultMail[0].isSuccess())
                response = 'Email sent successfully.';
            else { 
                response = 'Email failed to send.';
            }
    
        } catch (System.EmailException e) {
                response = e.getMessage();
        }
            
            return null;
    }*/

    
    
    @RemoteAction
    global static Boolean saveSurvey(String caseId,String surveyTemplateId,String surveyData,String vacancyContactId,Boolean sendEmail) {
        CustomerSuccessSurveyController controller = new CustomerSuccessSurveyController(null);
        //we should get the survey template from the id passed
        System.debug('Template id: '+surveyTemplateId+' Case Id: '+caseId+' data: '+surveyData+' vcontact: '+vacancyContactId);
        //make sure a survey entry does not already exist
        Survey_Template__c srv = controller.getTemplateById(surveyTemplateId);
        Vacancy_Contact__c vc = CustomerSuccessSurveyController.getVacancyContactById(vacancyContactId,caseId);
        List<Survey__c> surveyList = new List<Survey__c>();
        if(vc != null && srv != null) {
        	surveyList = [select Id from Survey__c where Case__c = :caseId and Survey_Template__c = :srv.Id 
        							  and Survey_Taker__c = :vc.Contact__c];
        }
        if(srv != null && surveyList.isEmpty()) {
            List<Survey_Metrics__c> metricsList = controller.getMetricsForSurvey(srv.Id);
            //we should now transform the survey data JSON into an apex class
            KeyPairContainer surveyDataList = (KeyPairContainer)JSON.deserialize(surveyData, KeyPairContainer.class);
            System.debug('Parsed data: '+surveyData+' number of values: '+surveyDataList.values.size());
            //we should transform this data based on the metrics for this survey to save back to a list of Metrics_Data__c objects associated to a Survey__c
            //object
            Survey__c survey = new Survey__c(Case__c = caseId, Survey_Template__c = srv.Id, Survey_Taker__c = vc.Contact__c, Send_Thank_You_Email__c = sendEmail);
            insert survey;
            List<Metrics_Data__c> dataItems = new List<Metrics_Data__c>();
            for(KeyPair item : surveyDataList.values) {
                Survey_Metrics__c srvMetric = null;
                for(Survey_Metrics__c m : metricsList) {
                    if(m.Name == item.key) {
                        srvMetric = m;
                        break;
                    }
                }
                if(srvMetric != null) {
                    Metrics_Data__c dataItem = new Metrics_Data__c(Case__c = caseId, Metrics__c = srvMetric.Metrics__r.Id, Response__c = item.value, 
                                                                   Survey_Number__c = survey.Id, Survey_Template__c = srv.Id, Survey_Taker__c = vc.Contact__c);
                    dataItems.add(dataItem);
                }
            }
            
            if(!dataItems.isEmpty()) {
                insert dataItems;
            } else {
                delete survey;
                
                return false;
            }
            
            return true;
        }
        //we should save the data in this controller.
        return false;
    }
    
    global static String getInstanceName() {
        String strUrl = URL.getSalesforceBaseUrl().toExternalForm();
        return strUrl.substring(strUrl.indexOf('://')+3,strUrl.indexOf('.'));
    }
    
    @RemoteAction
    global static Boolean sendSurvey(String caseId,String surveyTemplateId,String vacancyContactId) {
        String instanceName = System.URL.getSalesforceBaseUrl().getHost().substring(2);
        Boolean isSandbox = instanceName.startsWith('cs');
        Site surveySite = [select Id,subdomain from Site where urlpathprefix='CustomerSuccess'];
        String url = 'https://'+(isSandbox ? 'dev-' : '')+surveySite.subdomain+'.'+instanceName.substring(0,instanceName.indexOf('.'))+'.force.com/CustomerSuccess'
                   + '?id='+caseId+'&survey='+surveyTemplateId+'&contact='+vacancyContactId;
        //set the url to our case object
        Case cs = [select Id,Check_In_Survey_Link__c from Case where Id = :caseId];
        cs.Check_In_Survey_Link__c = url;
        update cs;
        Contact c = [select Id,Email from Contact where Id = :vacancyContactId];
        
        
        OrgWideEmailAddress owa = [select id, Address, DisplayName from OrgWideEmailAddress WHERE Address = 'voc.noreply@tesglobal.com'];

        
        //daisy send this url via email
        //retrieve the template id via the developer name.
        Id templateId = [select id, name from EmailTemplate where developername = 'Mid_Campaign_Check_In'].id;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setTemplateId(templateId);
        email.setSaveAsActivity(false);
        email.setTargetObjectId(c.Id);
        email.setWhatId(cs.Id);
        email.setToAddresses(new String[] {c.email});
        email.setOrgWideEmailAddressId(owa.ID) ;
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        return true;
    }
    
    global static Vacancy__c getVacancyFromCaseId(Id caseId) {
    	List<Vacancy__c> vacancyList = [SELECT ID FROM VACANCY__C WHERE ID IN (SELECT VACANCY__C FROM CASE WHERE ID = :caseId)];
    	if(!vacancyList.isEmpty()) {
    		return vacancyList[0];
    	}
    	
    	return null;
    }
    
    global static Contact getContactFromEmail(String email) {
    	List<Contact> contactList = [select Id,Salutation,FirstName,LastName,Email from Contact where Email = :email];
    	if(!contactList.isEmpty()) {
    		return contactList[0];
    	}
    	
    	return null;
    }
    
    @RemoteAction
    global static Contact createContact(String caseId,String salutation,String firstName,String lastName,String email,String phone) {
    	Vacancy__c vacancy = CustomerSuccessSurveyController.getVacancyFromCaseId(caseId);
    	if(vacancy != null) {
    		//before creating a contact on Salesforce make sure one with this e-mail address does not already exist.
    		Contact retval = CustomerSuccessSurveyController.getContactFromEmail(email);
    		if(retval == null) {
    			//we need to create the new contact.
    			Case refCase = [Select AccountId from Case where Id = :caseId];
    			
    			retval = new Contact(AccountId = refCase.AccountId, Salutation = Salutation, FirstName = firstName, LastName = lastName, Email = email, Phone = phone);
    			insert retval;
    			
    			//we now have to create a vacancy contact record.
    			Vacancy_Contact__c vc = new Vacancy_Contact__c(Vacancy__c = vacancy.Id, Contact__c = retval.Id, Recruitment_Owner__c = True);
    			insert vc;
    		} else {
    			//there might not be a vacancy contact for this contact so we should create one.
    			Vacancy_Contact__c vc = CustomerSuccessSurveyController.getVacancyContactById(retval.Id,caseId);
    			if(vc == null) {
    				Case refCase = [Select AccountId from Case where Id = :caseId];
    				
    				vc = new Vacancy_Contact__c(Vacancy__c = vacancy.Id, Contact__c = retval.Id, Recruitment_Owner__c = True);
    				insert vc;
    			}
    		}
    		
    		return retval;
    	}
    	
    	return null;
    }
}