@isTest
private class Zuora_PaymentPageControllerTest {

    static testMethod void TestPageRedirectWithNoPayment() {
        
        //As the payment method is empty this will always return an empty page ID 
        /*
        ApexPages.StandardController standardControllerObj = new ApexPages.StandardController(new zqu_Quote__c());
        Zuora_PaymentRedirectController paymentRedirectController=new Zuora_PaymentRedirectController(standardControllerObj);
        system.AssertEquals(paymentRedirectController.pageId,'');
        */
    }
}