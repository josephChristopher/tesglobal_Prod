<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Time_Stamp_Approval_Denial_Date</fullName>
        <field>Approval_Date_Time__c</field>
        <formula>now()</formula>
        <name>Time Stamp Approval/Denial Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Time Stamp Approval Date</fullName>
        <actions>
            <name>Time_Stamp_Approval_Denial_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Remedial_Action__c.Approval_Date_Time__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Remedial_Action__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved,Denied</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
