public with sharing class Zuora_PaymentPageController {
    
    // The Zuora id of the payment page
    public String pageId {
        get {
            if(pageId == null) pageId = '';
            return pageId;
        }
        set;
    }
    
    private String paymentMethodType = '';
    private zqu__Quote__c quote;
    
     
    public Zuora_PaymentPageController(ApexPages.StandardController standardController) {
        
         
        if(!Test.isRunningTest()) standardController.addFields(new List<String> {'zqu__PaymentMethod__c'});
         
        quote = (zqu__Quote__c)standardController.getRecord();
        
        if(quote != null) {
            paymentMethodType=quote.zqu__PaymentMethod__c; 
        }
        
    }
    
    public PageReference onload() {
        
        List<zqu__HostedPageLiteSetting__c> settingList = [SELECT zqu__PageId__c, zqu__PaymentMethodType__c, zqu__ComponentName__c FROM zqu__HostedPageLiteSetting__c WHERE zqu__PaymentMethodType__c = :paymentMethodType LIMIT 1];
    
        if(settingList != null && !settingList.isEmpty()) {
            pageId = settingList[0].zqu__PageId__c;
            return null;
        } else {
            system.debug('Invalid Payment Method Value Zuora_PaymentPageController controller.');
            String hostVal  = ApexPages.currentPage().getHeaders().get('Host');
            String urlVal = Apexpages.currentPage().getUrl();
            String urll = 'https://' + hostVal + '/' + quote.Id;
            
            PageReference somePage = new PageReference(urll);
           
            somePage.setRedirect(true);
            return somePage;
        }
        
      }
}