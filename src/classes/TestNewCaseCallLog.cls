@isTest

public class TestNewCaseCallLog {
    static testMethod void testNewCaseCallLog(){
         
        
        RecordType  cRecType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Customer Success Case - Surveys' LIMIT 1];
        
        
        //insert new case
            
                Case c = new Case();
                c.Status = 'Check In';
                c.Status_Custom__c = 'Awaiting Call';
                c.RecordTypeId = cRecType.Id;
            
            insert c;
        
        //update case
        
        c.Status_Custom__c = 'Call Complete';
            
            update c;
        
        //verify that a call log is created
        
        List<Call_Log__c> callLogList = [SELECT Id, Call_Date_Time__c, Old_Stage__c, Stage__c, Old_Status__c, Status__c, Case__c
                                        FROM Call_Log__c WHERE Case__c =: c.Id];
        
        for(Call_Log__c cl : callLogList) {
            
             system.assertEquals('Check In', cl.Old_Stage__c);
             system.assertEquals('Check In', cl.Stage__c);
            system.assertEquals('Awaiting Call', cl.Old_Status__c);
            system.assertEquals('Call Complete', cl.Status__c);
        } 
            
    }
}