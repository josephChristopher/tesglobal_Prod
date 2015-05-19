@isTest
public class TestUpdateAcctSalesmanTgr {

 static testMethod void testUpdateAcctSalesman(){
        
    // Set up the Region record.
    region__c region = new region__c (Name='United Kingdom', Description__c='n/a', 
                                     Salesman__c='Head of Regional Sales', 
                                     Account_Salesperson__c = 'Head of Regional Sales [n/a]');
    insert region;
    
    region__c region2 = new region__c (Name='Barnet', Description__c='n/a', 
                                     Salesman__c='London', 
                                     Account_Salesperson__c = 'London [n/a]');
    insert region2; 
     
    // Insert the Account record.
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
        
    //Trigger to update Account Salesman should execute.
    insert acc;
        
    //Verify that the correct Account Salesman based on region is selected.
    acc = [SELECT Account_Salesperson__c, Msl_Salesman__c 
           FROM Account
           WHERE Id = :acc.Id];
   
    System.assertEquals(region.Salesman__c, acc.Msl_Salesman__c);
    System.assertEquals(region.Account_Salesperson__c, acc.Account_Salesperson__c);
    
    //Verify the trigger works on update.    
    acc.Region_1__c = 'Classified';
    acc.Region_2__c = 'United Kingdom';
    acc.Region_3__c = 'England';
    acc.Region_4__c = 'London';
    acc.Region_5__c = 'Barnet'; 
    
    update acc; 
    
    acc = [SELECT Account_Salesperson__c, Msl_Salesman__c 
           FROM Account
           WHERE Id = :acc.Id];
   
    System.assertEquals(region2.Salesman__c, acc.Msl_Salesman__c);
    System.assertEquals(region2.Account_Salesperson__c, acc.Account_Salesperson__c);
        
    }
}