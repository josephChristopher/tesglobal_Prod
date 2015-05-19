@isTest

public class TestMassUpdateCallDates {
    
    static testMethod void testMassUpdateCallDates(){
        
        RecordType caseRecType = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND Name = 'Customer Success Case - Surveys'];
        
        
         Test.startTest();
            List<Case> newCases = new List<Case>();
            for(Integer i=0; i < 100; i++) {
                Case c = new Case();
                c.Status = 'Pre-Check In';
                c.Status_Custom__c = 'TBD';
                c.RecordTypeId = caseRecType.Id;
                newCases.add(c);
            }
        
        insert newCases;
        Test.stopTest();
    
    ApexPages.StandardSetController setCtrl = new ApexPages.StandardSetController(newCases);
        massUpdateCallDates sc = new massUpdateCallDates(setCtrl);
    
    }
}