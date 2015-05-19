@isTest
public class TestCreateMktShareCaseonOrganisation {
    
    static testmethod void TestCreateMktShareCaseonOrganisation(){
        
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
        
        test.stopTest();
        
        //verify that the organisation's current movement category, volumes ytd and priority are updated
        Organisation__c updatedOrg = [SELECT Id, Current_Movement_Category__c, Volumes_YTD__c, Local_Authority__c, Priority__c FROM Organisation__c WHERE Id =: org.Id];
        
        system.assertEquals('100% TES to left TES', updatedOrg.Current_Movement_Category__c);
        system.assertEquals(12, updatedOrg.Volumes_YTD__c);
        system.assertEquals('1 - Very High', updatedOrg.Priority__c);
        
        //verify that a market share case has been created for that organisation
        Case newMarketShareCase = [SELECT Id, SD_Name__c, RecordTypeId, Origin, Status, Status_Custom__c, Priority FROM Case WHERE SD_Name__c =: updatedOrg.Id];
        RecordType marketShareCaseRecType = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Market Share Case' LIMIT 1];
 
        system.assertEquals('Marketshare Database', newMarketShareCase.Origin);
        system.assertEquals('Engagement Contact', newMarketShareCase.Status);
        system.assertEquals('Awaiting Call', newMarketShareCase.Status_Custom__c);
        system.assertEquals(marketShareCaseRecType.Id, newMarketShareCase.RecordTypeId);
        system.assertEquals('1 - Very High', newMarketShareCase.Priority);
    }

}