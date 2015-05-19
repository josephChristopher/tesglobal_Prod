<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Final_Region_on_Lead</fullName>
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
        <name>Update Final Region on Lead</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Final Region on Lead</fullName>
        <actions>
            <name>Update_Final_Region_on_Lead</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Region to the final region selected.</description>
        <formula>OR(ISCHANGED(Region_1__c),  ISCHANGED(Region_2__c),  ISCHANGED(Region_3__c),  ISCHANGED(Region_4__c),  ISCHANGED(Region_5__c),  NOT(ISBLANK(TEXT(Region_1__c))),  NOT(ISBLANK(TEXT(Region_2__c))),  NOT(ISBLANK(TEXT(Region_3__c))),  NOT(ISBLANK(TEXT(Region_4__c))),  NOT(ISBLANK(TEXT(Region_5__c))))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
