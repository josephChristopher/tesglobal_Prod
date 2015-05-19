<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_Mid_Campaign_Survey_Thank_You</fullName>
        <ccEmails>cstsent@tesglobal.com</ccEmails>
        <description>Email Alert Mid Campaign Survey Thank You</description>
        <protected>false</protected>
        <recipients>
            <field>Survey_Taker_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>voc.noreply@tesglobal.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Customer_Success/MidCampaignCheckInThankYouEmail</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_Mid_Campaign_Survey_Thank_You_Call</fullName>
        <ccEmails>cstsent@tesglobal.com</ccEmails>
        <description>Email Alert Mid Campaign Survey Thank You - Call</description>
        <protected>false</protected>
        <recipients>
            <field>Survey_Taker_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>voc.noreply@tesglobal.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Customer_Success/MidCampaignCheckInThankYouCall</template>
    </alerts>
    <fieldUpdates>
        <fullName>Check_Mid_Campaign</fullName>
        <field>Mid_Campaign__c</field>
        <literalValue>1</literalValue>
        <name>Check Mid Campaign</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Survey_Taker_Email</fullName>
        <field>Survey_Taker_Email__c</field>
        <formula>Survey_Taker__r.Email</formula>
        <name>Update Survey Taker Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Check Mid Campaign</fullName>
        <actions>
            <name>Check_Mid_Campaign</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Survey_Template__r.Name = &quot;TES Recruitment Two Minute Survey&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Thank You Email</fullName>
        <actions>
            <name>Email_Alert_Mid_Campaign_Survey_Thank_You</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISBLANK( Survey_Taker_Email__c )), 
Survey_Template__r.Name = &quot;TES Recruitment Two Minute Survey&quot;, 
CreatedBy.LastName = &quot;Stura&quot; 
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Thank You Email - Call</fullName>
        <actions>
            <name>Email_Alert_Mid_Campaign_Survey_Thank_You_Call</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISBLANK( Survey_Taker_Email__c )), 
Survey_Template__r.Name = &quot;TES Recruitment Two Minute Survey&quot;, 
Send_Thank_You_Email__c = TRUE,
CreatedBy.LastName != &quot;Stura&quot;  
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Survey Taker Email</fullName>
        <actions>
            <name>Update_Survey_Taker_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISBLANK( Survey_Taker_Email__c ),  Survey_Template__r.Name = &quot;TES Recruitment Two Minute Survey&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
