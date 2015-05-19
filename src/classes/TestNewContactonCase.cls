@isTest
public class TestNewContactonCase {
    
    public static testMethod void TestNewContactonCase() {
        
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
        
        RecordType cRecType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Customer Success'];
        
        //create new contact
        Contact c = new Contact();
        c.LastName = 'smith';
        c.RecordTypeId = cRecType.Id;
        c.Phone = '12312312321';
        c.Email = 'asdsa@dadsa.com';
        c.AccountId = acc.Id;
        c.Salutation = 'Ms.';
        
        insert c;
        
        RecordType complaintsRT = [SELECT Id from RecordType WHERE sObjectType = 'Case' AND Name = 'Complaints']; 
        
        //insert cases with existing email
        List<Case> newCases = new List<Case>();
        for(Integer i=0; i < 100; i++) {    
            
            Case cs = new Case(
                RecordTypeId = complaintsRt.Id,
                Salutation__c = 'ms.',
                School_Institution__c = 'test school',
                Contact_Last_Name__c = 'smith',
                Contact_Email__c = 'asdsa@dadsa.com',
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
        
        //insert cases with new email
        List<Case> casesNewEmail = new List<Case>();
        for(Integer i=0; i < 100; i++) {    
            
            Case cs = new Case(
                RecordTypeId = complaintsRt.Id,
                Salutation__c = 'ms.',
                School_Institution__c = 'test school',
                Contact_Last_Name__c = 'smith',
                Contact_Email__c = 'something890@something.com',
                Contact_Phone__c = '3213123',
                Reason_for_Complaint__c = 'Booking Error',
                Description = 'test',
                Main_Reason_for_Complaint__c = 'test',
                Reported_By__c = 'test',
                Reported_By_Team__c = 'test',
                Origin = 'QMS',
                AccountId = acc.Id
            );
            
             casesNewEmail.add(cs);
            
        }
            
            insert casesNewEmail;
        
        //update cases with account
        for(Case cs : newCases) {
            cs.AccountId = acc.Id;
        }
        
        update newCases;
        
    }     
    

}