@isTest

public class TestComplaintsFormController {
    
    public static testMethod void TestComplaintsFormController() {
        
        RecordType complaintsRT = [SELECT Id from RecordType WHERE sObjectType = 'Case' AND Name = 'Complaints']; 
        
        //insert new cases
        List<Case> newCases = new List<Case>();
        for(Integer i=0; i < 100; i++) {    
            
            Case cs = new Case(
                RecordTypeId = complaintsRt.Id,
                Salutation__c = 'ms.',
                School_Institution__c = 'test school',
                Contact_Last_Name__c = 'smith',
                Contact_Email__c = 'smith@dsadsa.com',
                Contact_Phone__c = '3213123',
                Reason_for_Complaint__c = 'Booking Error',
                Description = 'test',
                Main_Reason_for_Complaint__c = 'test',
                Reported_By__c = 'test',
            	Reported_By_Team__c = 'test'
            );
            
             newCases.add(cs);
            
        }
            
            insert newCases;
        
        //insert account
        Account acc = new Account(Name='Test Account',
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
                                  Not_Approved_by_Finance__c = false);
        
        insert acc;

        
        //update case with account
        for(Case c : newCases) {
            c.AccountId = acc.Id;
        }
        
        update newCases;
        

            PageReference pg = Page.CaseFormIntl;
            Test.setCurrentPage(pg); 
            
            ApexPages.StandardSetController setCtrl = new ApexPages.StandardSetController(newCases);
            ComplaintsFormController ext = new ComplaintsFormController(setCtrl);
            
            PageReference saveComplaintInternal = ext.saveComplaintInternal();
        
            PageReference saveComplaint = ext.saveComplaint();
        
            PageReference setCaseTypetoComplaint = ext.setCaseTypetoComplaint();
        
            PageReference setCaseTypetoQuery = ext.setCaseTypetoQuery();
        
            PageReference setCaseTypetoComment = ext.setCaseTypetoComment();
        
            PageReference complaintsForm = ext.complaintsForm();
        
            PageReference complaintsFormIntl = ext.complaintsFormIntl();

 
        }
        
    }