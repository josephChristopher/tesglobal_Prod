<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_contact_delivery_opt_to_royal_mail</fullName>
        <field>Delivery_Option__c</field>
        <literalValue>Royal Mail</literalValue>
        <name>Set contact delivery opt to royal mail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_delivery_option_changed_date</fullName>
        <field>Delivery_Option_Date_Changed__c</field>
        <formula>NOW()</formula>
        <name>Update delivery option changed date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Send_B2C_sec_contact_update_message</fullName>
        <apiVersion>33.0</apiVersion>
        <endpointUrl>http://cloudreach-connect-shared.herokuapp.com/ccsvc/tes/entitlement/seccontactupdate?key=2379d0c6-7438-4ab5-ab5b-893f5ea721cd&amp;ENV=PRODUCTION</endpointUrl>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>jciccarelli@tesglobal.com</integrationUser>
        <name>Send B2C sec contact update message</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>B2C_When_shipping_address_is_updated</fullName>
        <actions>
            <name>Set_contact_delivery_opt_to_royal_mail</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_delivery_option_changed_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>RecordType.Name = &apos;B2C&apos; &amp;&amp; (ISCHANGED( MailingCity ) || ISCHANGED(MailingCountry) || ISCHANGED(MailingPostalCode) || ISCHANGED(MailingStreet) || ISCHANGED( MailingState ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TES B2C Secondary Contact Message Queue Notification</fullName>
        <actions>
            <name>Send_B2C_sec_contact_update_message</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Type__c</field>
            <operation>equals</operation>
            <value>Secondary</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>B2C</value>
        </criteriaItems>
        <description>This will insert the secondary contact in entitlement if does not exist</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
