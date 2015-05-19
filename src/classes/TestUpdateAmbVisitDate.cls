@isTest
public class TestUpdateAmbVisitDate {
    
    static testmethod void TestUpdateAmbVisitDate(){
        
        test.startTest();
        
         //insert country
        Country__c country = new Country__c ();
        country.Name = 'TEST';
        country.title__c = 'TEST';
        country.part_of_uk__c = TRUE;
        
        insert country;
        
        //insert local authority
        Local_Authority__c localAuthority = new Local_Authority__c ();
        localAuthority.Name = 'Test Local Authority';
        localAuthority.Region__c = 'Test Region';
        localAuthority.Country__c = country.Id;
        
        insert localAuthority;
        
        //insert organisation
        Organisation__c org = new Organisation__c();
        org.Name = 'Test School';
        org.Address_1__c = 'Test Address 1';
        org.County__c = 'Test County';
        org.Postcode__c = '123321';
        org.Country__c = country.Id;
        org.local_authority__c = localAuthority.Id;
        
        insert org;
        
        //insert market share log
        Market_Share_Log__c mktShare = new Market_Share_Log__c();
        mktShare.Current_Movement_Category__c = '100% TES to left TES';
        mktShare.Volumes_YTD__c = 12;
        mktShare.SD_Name__c = org.Id;
        
        insert mktShare;
        
        //select the case that was inserted when market share log is inserted
        Case newMarketShareCase = [SELECT Id, SD_Name__c, RecordTypeId, Origin, Status, Status_Custom__c, Priority FROM Case WHERE SD_Name__c =: org.Id];
   		
        RecordType ambassadorVisitEventRT = [SELECT Id FROM RecordType WHERE sObjectType = 'Event' AND Name = 'Ambassador Visit'];
        
        //insert an event against the market share case
        Event ambassadorVisit = new Event();
        ambassadorVisit.ActivityDate = date.newInstance(2015, 09, 13);
        ambassadorVisit.Location = 'test location';
        ambassadorVisit.RecordTypeId = ambassadorVisitEventRT.Id;
        ambassadorVisit.Subject = 'test';
        ambassadorVisit.WhatId = newMarketShareCase.Id;
        ambassadorVisit.DurationInMinutes = 60;
        ambassadorVisit.StartDateTime = datetime.newInstance(2015, 09, 13, 7, 8, 16);
        ambassadorVisit.EndDateTime = datetime.newInstance(2015, 09, 13, 8, 8, 16);
        
        insert ambassadorVisit;
        
        test.stopTest();
        
        //verify that the case ambassador status is updated
        Case updatedCase = [SELECT Id, Status, Status_Custom__c FROM Case WHERE Id =: newMarketShareCase.Id];
        
        system.assertEquals(updatedCase.Status, 'Ambassador Contact');
        system.assertEquals(updatedCase.Status_Custom__c, 'Awaiting Visit');
        
        //verify that the org scheduled visit date is updated
        Organisation__c updatedorg = [SELECT Id, Visit_Start_Date_Time__c, Visit_End_Date_Time__c FROM Organisation__c WHERE Id =: org.Id];
        
        system.assertEquals(updatedorg.Visit_Start_Date_Time__c, datetime.newInstance(2015, 09, 13, 7, 8, 16));
        system.assertEquals(updatedorg.Visit_End_Date_Time__c, datetime.newInstance(2015, 09, 13, 8, 8, 16));
    }

}