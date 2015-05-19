<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Close_Date_to_Now</fullName>
        <field>Close_Date__c</field>
        <formula>NOW()</formula>
        <name>Update Close Date to Now</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Proposal_Create_to_Edit</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Closed_Proposal</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Proposal to Closed Proposal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Proposal_Status_to_Closed</fullName>
        <field>Proposal_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Update Proposal Status to &quot;Closed&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Proposal Record Type to Closed</fullName>
        <actions>
            <name>Update_Proposal_Create_to_Edit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Proposal__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Open Proposal</value>
        </criteriaItems>
        <description>Updates Proposal Record Type from Open Proposal to Closed Proposal</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Proposal Status to Closed and Close Date</fullName>
        <actions>
            <name>Update_Close_Date_to_Now</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Proposal_Status_to_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Proposal Status to &quot;Closed&quot; and populate Close Date if the Stage contains &quot;Closed&quot;</description>
        <formula>CONTAINS(TEXT(Stage__c), &quot;Closed&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
