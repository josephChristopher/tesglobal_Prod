<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Record_Type_to_Locked</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Salesform_Locked</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type to Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Record Type to Locked</fullName>
        <actions>
            <name>Update_Record_Type_to_Locked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Sales_Form__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Salesform Locked</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
