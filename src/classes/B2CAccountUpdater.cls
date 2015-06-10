/**
* B2CAccountUpdate Trigger Handler class on Account Object
* When new account created or updated this create or Update
* two Contact record in Contact Object (Contact Type 'Primary' and 'Shipping'). 
* Always change Delivery option to 'Royal Mail' as asked by Amanda.
* @author: Javier, Fayyaz
* Cloudreach Euorope Ltd
*/
public class B2CAccountUpdater {

    List<SObject> b2cContact;

    private static final String B2C_CONTACT_RECORD_TYPE_NAME = 'B2C';
    private static final Id B2C_CONTACT_RECORD_TYPE_ID = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND Name = :B2C_CONTACT_RECORD_TYPE_NAME].Id;

    private List<Contact> b2cContacts;
    private Map<Object, SObject> contactsByAccountId = new Map<Object, SObject>();

    public B2CAccountUpdater(List<Contact> updatedContacts) {
        b2cContacts = new List<Contact>();

        System.debug('B2C RECORDTYPE ' + B2C_CONTACT_RECORD_TYPE_ID);
        for (Contact cont : updatedContacts) {
            if (cont.recordTypeId == B2C_CONTACT_RECORD_TYPE_ID && (cont.Type__c == 'Primary' || cont.Type__c == 'Shipping')) {
                b2cContacts.add(cont);
                System.debug('B2C CONTACT '  + cont + ' RECORD TYPE ' + cont.recordTypeId + ' TYPE: ' + cont.Type__c);
            }
        }

        if (!b2cContacts.isEmpty())
            contactsByAccountId = Reach.Utils.collect(b2cContacts).byField(Contact.AccountId).noDuplicates(); //if there are many, use the last one.

    }

    public void updateAccounts() {
        if (b2cContacts == null || b2cContacts.isEmpty())
            return;
            
        Set<Id> accountIds = listCastToId(contactsByAccountId.keySet());
        List<Account> accountsToUpdate = [SELECT Id FROM account WHERE Id IN :accountIds];

        for (Account accToUpdate : accountsToUpdate) {
            Contact cont = (Contact) contactsByAccountId.get(accToUpdate.Id);

            if (cont == null)
                continue; //orphan contact

            updateAccountFromContact(accToUpdate, cont);
        }

        update accountsToUpdate;
    }

    private Set<Id> listCastToId(Set<Object> ids) {
        Set<Id> newIds = new Set<Id>();
        
        for (Object anId : ids)
            newIds.add((Id) anId);

        return newIds;
    }

    private void updateAccountFromContact(Account dest, Contact source) {
        if (source.Type__c == 'Primary') {
            dest.Billing_First_Name__c = source.FirstName;
            dest.Billing_Last_Name__c = source.LastName;
            dest.Billing_Email_Address__c = source.Email;
            dest.Billing_Title__c = source.Salutation;
            dest.BillingStreet = source.MailingStreet;
            dest.BillingCity = source.MailingCity;
            dest.BillingCountry = source.MailingCountry;
            dest.BillingPostalCode = source.MailingPostalCode;
            dest.Billing_Phone__c = source.Phone;
        }
        if (source.Type__c == 'Shipping') {
            dest.Shipping_First_Name__c = removeString('[Shipping]', source.FirstName);
            dest.Shipping_Last_Name__c = source.LastName;
            dest.Shipping_Email_Address__c = source.Email;
            dest.Shipping_Title__c = source.Salutation;
            dest.ShippingStreet = source.MailingStreet;
            dest.ShippingCity = source.MailingCity;
            dest.ShippingCountry = source.MailingCountry;
            dest.ShippingPostalCode = source.MailingPostalCode;
            dest.Shipping_Phone__c = source.Phone;

        }
    }

    private String removeString(String toRemove, String original) {
        if (original == null || String.isBlank(original) || !original.contains(toRemove))
            return original;

        String[] splittedString = original.split(toRemove, 2);

        return splittedString[1].trim();

    }
    
    
   
}