/**
* B2CCOntactCreator Trigger Handler class on Account Object
* When new account created or updated this create or Update
* two Contact record in Contact Object (Contact Type 'Primary' and 'Shipping'). 
* Always change Delivery option to 'Royal Mail' as asked by Amanda.
* @ Author: Javier, Fayyaz
* Cloudreach Euorope Ltd
*/
public class B2CContactsCreator {
    
    private static final String B2C_ACCOUNT_RECORD_TYPE_NAME = 'B2C Account';
    private static final String B2C_CONTACT_RECORD_TYPE_NAME = 'B2C';

    private List<Account> b2cAccounts = new List<Account>();
    private Set<Id> b2cAccountIds = new Set<Id>();
    private Id b2cContactRecordTypeId = null;
    private Id b2cAccountRecordTypeId = null;
    
    public B2CContactsCreator(List<Account> newAccounts) {
        b2cAccountRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = :B2C_ACCOUNT_RECORD_TYPE_NAME].Id;

        for (Account newAccount : newAccounts) {
            System.debug('Account with ID ' + newAccount.Id + ' has record type name = [' + newAccount.RecordType.Name + ']');
            if (newAccount.RecordTypeId == b2cAccountRecordTypeId) {
                System.debug('Account matches record type');
                b2cAccounts.add(newAccount);
                b2cAccountIds.add(newAccount.Id);
            }
        }
        
        if (!b2cAccounts.isEmpty())
            b2cContactRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = :B2C_CONTACT_RECORD_TYPE_NAME].Id;
    }

    public void updateContacts() {
        List<Contact> contactsToUpdate = new List<Contact>();


        List<Contact> billingContacts =  [SELECT AccountId, LastName,FirstName, Email, Salutation, RecordTypeId,
                                                MailingStreet, MailingCity, MailingCountry, MailingPostalCode, Delivery_option__c  
                                                FROM Contact WHERE 
                                                AccountId IN :b2cAccountIds AND Type__c='Primary'];

        Map<Object, SObject> billingContactsByAccountId = Reach.Utils.collect(billingContacts).byField(Contact.AccountId).noDuplicates();


        List<Contact> shippingContacts =  [SELECT AccountId, LastName,FirstName, Email, Salutation, RecordTypeId,
                                                MailingStreet, MailingCity, MailingCountry, MailingPostalCode, Delivery_option__c  
                                                FROM Contact WHERE 
                                                AccountId IN :b2cAccountIds AND Type__c='Shipping'];        
        Map<Object, SObject> shippingContactsByAccountId = Reach.Utils.collect(shippingContacts).byField(Contact.AccountId).noDuplicates();

        for (Account a : b2cAccounts) {

            Contact billingContact = (Contact) billingContactsByAccountId.get(a.Id);
            Contact shippingContact = (Contact) shippingContactsByAccountId.get(a.Id);

            if (billingContact == null)
                billingContact = new Contact();

            if (shippingContact == null && billingAddressIsDifferentToShippingAddress(a))
                shippingContact = new Contact();

            contactsToUpdate.add(populateBillingContact(a, billingContact));
            
            if (shippingContact != null)               
                 contactsToUpdate.add(populateShippingContact(a, shippingContact));
        }

        upsert contactsToUpdate;
    }

    
    public void createContacts() {
        List<Contact> newContacts = new List<Contact>();
        
        for (Account a : b2cAccounts) {
           
            newContacts.add(populateBillingContact(a, new Contact()));

            if (billingAddressIsDifferentToShippingAddress(a)) {
                newContacts.add(populateShippingContact(a, new Contact()));
             }
        }
        
        insert newContacts;
    }

    private Contact populateBillingContact(Account a, Contact billingContact) { 
        billingContact.LastName = a.Billing_Last_Name__c;
        billingContact.FirstName =  a.Billing_First_Name__c;
        billingContact.Email = a.Billing_Email_Address__c;
        billingContact.Salutation = a.Billing_Title__c;
        billingContact.RecordTypeId = b2cContactRecordTypeId;
        billingContact.MailingStreet = a.BillingStreet;
        billingContact.MailingCity = a.BillingCity;
        billingContact.MailingCountry = a.BillingCountry;
        billingContact.MailingPostalCode = a.BillingPostalCode;
        billingContact.Type__c = 'Primary';
        billingContact.AccountId = a.Id;
        billingContact.Phone = a.Billing_Phone__c;
        return billingContact;
    }

    private String getConcatenated(String toConcat, String originalString) {
        if (toConcat == null)
            return originalString;

        if (originalString == null)
            originalString = '';

        return (toConcat + originalString).trim();

    }

    private Contact populateShippingContact(Account a, Contact shippingContact) {
        shippingContact.LastName = a.Shipping_Last_Name__c;
        shippingContact.FirstName = getConcatenated('[Shipping] ', a.Shipping_First_Name__c);
        shippingContact.Email = a.Shipping_Email_Address__c;
        shippingContact.Salutation = a.Shipping_Title__c;
        shippingContact.RecordTypeId = b2cContactRecordTypeId;
        shippingContact.MailingStreet = a.ShippingStreet;
        shippingContact.MailingCity = a.ShippingCity;
        shippingContact.MailingCountry = a.ShippingCountry;
        shippingContact.MailingPostalCode = a.ShippingPostalCode;
        shippingContact.Type__c = 'Shipping';
        shippingContact.Delivery_option__c = 'Royal Mail';
        shippingContact.Phone = a.Shipping_Phone__c;

        //shippingContact.Mailing_Address_Changed_Date__C= System.today();
        shippingContact.AccountId = a.Id;
        return shippingContact;
    }
    
    private Boolean billingAddressIsDifferentToShippingAddress(Account a) {
        return (a.ShippingStreet != null && a.ShippingStreet != a.BillingStreet) 
            || (a.ShippingCity != null && a.ShippingCity != a.BillingCity)
            || (a.ShippingCountry != null && a.ShippingCountry != a.BillingCountry)
            || (a.ShippingPostalCode != null && a.ShippingPostalCode != a.BillingPostalCode)
            || (a.Shipping_Last_Name__c != null && a.Shipping_Last_Name__c != a.Billing_Last_Name__c)
            || (a.Shipping_First_Name__c != null && a.Shipping_First_Name__c != a.Billing_First_Name__c)
            || (a.Shipping_Email_Address__c != null && a.Shipping_Email_Address__c != a.Billing_Email_Address__c)
            || (a.Shipping_Phone__c != null && a.Shipping_Phone__c != a.Billing_Phone__c);

    }

}