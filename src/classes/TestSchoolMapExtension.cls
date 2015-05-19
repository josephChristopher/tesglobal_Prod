@isTest
public class TestSchoolMapExtension {
    
    public static TestMethod void TestSchoolMapExtension(){
        
        //insert country
        Country__c cy = new Country__c ();
        cy.Name = 'TEST';
        cy.title__c = 'TEST';
        
        insert cy;
        
        //insert organisation
        Organisation__c org = new Organisation__c();
        org.Name = 'Test School';
        org.Address_1__c = 'Test Address 1';
        org.County__c = 'Test County';
        org.Postcode__c = '123321';
        org.Country__c = cy.Id;
        
        insert org;
        
        Test.startTest();
        PageReference pageRef = Page.SchoolMapPage;
        Test.setCurrentPage(pageRef);
        
         // Add parameters to page URL
        ApexPages.currentPage().getParameters().put('Id', org.Id);
        SchoolMapExtension ext = new SchoolMapExtension(new ApexPages.StandardController(org) );
	   ext.phasesFilter.add('secondary');
        
        List<String> phaseList = ext.phasesFilter;
        phaseList.add('Primary');
        phaseList.add('Secondary');
        
        ext.filterKeys.put('Phase', phaseList);
        
        String phases = ext.phases;
        
        List<String> fundingGroupList = ext.fundingGroupFilter;
        fundingGroupList.add('State');
        fundingGroupList.add('Independent');
        
        ext.filterKeys.put('Funding Group', fundingGroupList);
        
        String fundingGroups = ext.fundingGroups;
        
        ext.createfilterMap();
        
        SchoolMapExtension ext2 = new SchoolMapExtension();
        
        SchoolMapExtension ext3 = new SchoolMapExtension(new ApexPages.StandardController(org) );
        
        List<String> emptyPhasesList = null;
        emptyPhasesList = ext3.phasesFilter;
        ext3.filterKeys.put('Phase', emptyPhasesList);
        String emptyphases = ext3.phases;
        
        List<String> emptyFundingGroupsList = null;
        emptyFundingGroupsList = ext3.fundingGroupFilter;
        ext3.filterKeys.put('Funding Group', emptyFundingGroupsList);
        String emptyfundinggroup = ext3.fundingGroups;
        
        test.stopTest();
        
    }

}