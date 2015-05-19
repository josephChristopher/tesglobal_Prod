<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Check_Not_Approved_Checkbox</fullName>
        <field>Not_Approved_by_Finance__c</field>
        <literalValue>1</literalValue>
        <name>Check Not Approved Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Record_Type_to_EditLocked</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Account_Edit_Locked</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Account Record Type to EditLocked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Mandatory_Order_Number_to_True</fullName>
        <field>Mandatory_Order_Number__c</field>
        <literalValue>1</literalValue>
        <name>Update Mandatory Order Number to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Region_to_Final_Region</fullName>
        <field>Region__c</field>
        <formula>IF(NOT(ISBLANK(TEXT(Region_5__c))), 
   TEXT(Region_5__c),

IF(AND(ISBLANK(TEXT(Region_5__c)), 
       NOT(ISBLANK(TEXT(Region_4__c)))), 
   TEXT(Region_4__c),

IF(AND(ISBLANK(TEXT(Region_5__c)),
       ISBLANK(TEXT(Region_4__c)),
       NOT(ISBLANK(TEXT(Region_3__c)))), 
   TEXT(Region_3__c),

IF(AND(ISBLANK(TEXT(Region_5__c)),
       ISBLANK(TEXT(Region_4__c)),
       ISBLANK(TEXT(Region_3__c)),
       NOT(ISBLANK(TEXT(Region_2__c)))),  
   TEXT(Region_2__c),

IF(AND(ISBLANK(TEXT(Region_5__c)),
       ISBLANK(TEXT(Region_4__c)),
       ISBLANK(TEXT(Region_3__c)),
       ISBLANK(TEXT(Region_2__c)),
       NOT(ISBLANK(TEXT(Region_1__c)))), 
   TEXT(Region_1__c),

&quot;&quot;)))))</formula>
        <name>Update Region to Final Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Account_Edit</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Account_Edit</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update to Account Edit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Check Not Approved in Account After Creation</fullName>
        <actions>
            <name>Check_Not_Approved_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Account Creation</value>
        </criteriaItems>
        <description>Check the Not Approved checkbox automatically after the account is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Account Creation to Account Edit Locked</fullName>
        <actions>
            <name>Update_Account_Record_Type_to_EditLocked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Account record type to Account Edit Locked after a user creates an account.</description>
        <formula>OR( RecordType.Name = &quot;Account Creation&quot;,    AND(  Lock_When_Converted__c = TRUE,          RecordType.Name != &quot;Account Edit Locked&quot;       ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Account Edit Locked to Account Edit</fullName>
        <actions>
            <name>Update_to_Account_Edit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Account record type from Account Edit Locked to Account Edit after the web service populates the MSL ID.</description>
        <formula>AND( RecordType.Name = &quot;Account Edit Locked&quot;, NOT(ISBLANK( Msl_Id__c )))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Final Region on Account</fullName>
        <actions>
            <name>Update_Region_to_Final_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the &quot;Region&quot; field with the final region selected by the user.</description>
        <formula>OR(ISCHANGED(Region_1__c), ISCHANGED(Region_2__c), ISCHANGED(Region_3__c), ISCHANGED(Region_4__c), ISCHANGED(Region_5__c), NOT(ISBLANK(TEXT(Region_1__c))), NOT(ISBLANK(TEXT(Region_2__c))), NOT(ISBLANK(TEXT(Region_3__c))), NOT(ISBLANK(TEXT(Region_4__c))), NOT(ISBLANK(TEXT(Region_5__c))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Mandatory Order Number to True if Agency</fullName>
        <actions>
            <name>Update_Mandatory_Order_Number_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Agency__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Update Mandatory Order Number to True if Agency = TRUE</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
