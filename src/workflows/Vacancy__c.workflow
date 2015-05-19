<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Check_in_Date</fullName>
        <field>Check_In_Date__c</field>
        <formula>CASE( 
MOD((DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 )) - Date(1900, 1, 7), 7), 
0, (DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 ))+1, 
1, (DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 )), 
2, (DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 )), 
3, (DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 )), 
4, (DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 )), 
5, (DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 )), 
(DATEVALUE(Date_of_Ad_Publication_on_TES_Site__c) + (Ad_Live_Duration_Days__c/2 ))+2 
)</formula>
        <name>Update Check in Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Customer_Care_Call_Date</fullName>
        <field>Customer_Care_Call_Date__c</field>
        <formula>CASE( 
MOD((DATEVALUE( Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42) - Date(1900, 1, 7), 7), 
0, (DATEVALUE(Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42)+1, 
1, (DATEVALUE(Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42), 
2, (DATEVALUE(Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42), 
3, (DATEVALUE(Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42), 
4, (DATEVALUE(Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42), 
5, (DATEVALUE(Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42), 
(DATEVALUE(Date_of_Ad_Expiry_on_TES_Global_Site__c ) + 42)+2 
)</formula>
        <name>Update Customer Care Call Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_High</fullName>
        <field>Priority__c</field>
        <literalValue>2 - High</literalValue>
        <name>Update Priority to High</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_Low</fullName>
        <field>Priority__c</field>
        <literalValue>4 - Low</literalValue>
        <name>Update Priority to Low</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_Medium</fullName>
        <field>Priority__c</field>
        <literalValue>3 - Medium</literalValue>
        <name>Update Priority to Medium</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_Very_High</fullName>
        <field>Priority__c</field>
        <literalValue>1 - Very High</literalValue>
        <name>Update Priority to Very High</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_Very_Low</fullName>
        <field>Priority__c</field>
        <literalValue>5 - Very Low</literalValue>
        <name>Update Priority to Very Low</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Vacancy_to_Locked</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Vacancy_Locked</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Vacancy to Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Priority to High</fullName>
        <actions>
            <name>Update_Priority_to_High</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Vacancy Priority to High</description>
        <formula>OR(AND(Tier_by_Ad_Spend__c = &quot;Tier 1&quot;,        OR(AND(Job_Role_Classification__c = &quot;Secondary&quot;,               Hard_to_Fill__c = False),           Job_Role_Classification__c = &quot;Primary&quot;           )        ),    AND(Tier_by_Ad_Spend__c = &quot;Tier 2&quot;,        Job_Role_Classification__c = &quot;Secondary&quot;,        Hard_to_Fill__c = False,        Agency__c = False        ),    AND(Tier_by_Ad_Spend__c = &quot;Tier 2&quot;,        Job_Role_Classification__c = &quot;Primary&quot;,        Agency__c = False        ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Priority to Low</fullName>
        <actions>
            <name>Update_Priority_to_Low</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Vacancy Priority to Low</description>
        <formula>OR(AND(OR(Tier_by_Ad_Spend__c = &quot;Tier 3&quot;, 
Tier_by_Ad_Spend__c = &quot;Tier 4&quot; 
), 
Job_Role_Classification__c = &quot;Secondary&quot;, 
Hard_to_Fill__c = False, 
Agency__c = True 
), 
AND(Tier_by_Ad_Spend__c = &quot;Tier 5&quot;, 
Job_Role_Classification__c = &quot;Secondary&quot;, 
Hard_to_Fill__c = False, 
Agency__c = False 
), 
AND(Tier_by_Ad_Spend__c = &quot;Tier 3&quot;, 
Job_Role_Classification__c = &quot;Primary&quot;, 
Agency__c = True 
), 
AND(Tier_by_Ad_Spend__c = &quot;Tier 4&quot;, 
Job_Role_Classification__c = &quot;Primary&quot;, 
Agency__c = False 
), 
AND(ISBLANK(Tier_by_Ad_Spend__c), 
Agency__c = True, 
Hard_to_Fill__c = False, 
Job_Role_Classification__c = &quot;Secondary&quot; 
), 
AND(ISBLANK(Tier_by_Ad_Spend__c), 
Agency__c = False, 
Job_Role_Classification__c = &quot;Primary&quot; 
) 
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Priority to Medium</fullName>
        <actions>
            <name>Update_Priority_to_Medium</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Vacancy Priority to Medium</description>
        <formula>OR(AND(Tier_by_Ad_Spend__c = &quot;Tier 2&quot;, 
Job_Role_Classification__c = &quot;Secondary&quot;, 
Hard_to_Fill__c = False, 
Agency__c = True 
), 
AND(Tier_by_Ad_Spend__c = &quot;Tier 2&quot;, 
Job_Role_Classification__c = &quot;Primary&quot;, 
Agency__c = True 
), 
AND(OR(Tier_by_Ad_Spend__c = &quot;Tier 3&quot;, 
Tier_by_Ad_Spend__c = &quot;Tier 4&quot; 
), 
Job_Role_Classification__c = &quot;Secondary&quot;, 
Hard_to_Fill__c = False, 
Agency__c = False 
), 
AND(Tier_by_Ad_Spend__c = &quot;Tier 3&quot;, 
Job_Role_Classification__c = &quot;Primary&quot;, 
Agency__c = False 
), 
AND(ISBLANK(Tier_by_Ad_Spend__c), 
Agency__c = False, 
Hard_to_Fill__c = False, 
Job_Role_Classification__c = &quot;Secondary&quot; 
) 

)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Priority to Very High</fullName>
        <actions>
            <name>Update_Priority_to_Very_High</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Vacancy Priority to Very High</description>
        <formula>OR(Job_Role_Classification__c = &quot;Leadership&quot;,      AND(Job_Role_Classification__c = &quot;Secondary&quot;,                Hard_to_Fill__c = TRUE)     )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Priority to Very Low</fullName>
        <actions>
            <name>Update_Priority_to_Very_Low</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Vacancy Priority to Very Low</description>
        <formula>OR(AND(OR(Tier_by_Ad_Spend__c = &quot;Tier 4&quot;, 
Tier_by_Ad_Spend__c = &quot;Tier 5&quot; 
), 
Job_Role_Classification__c = &quot;Primary&quot;, 
Agency__c = True 
), 
AND(Tier_by_Ad_Spend__c = &quot;Tier 5&quot;, 
Job_Role_Classification__c = &quot;Secondary&quot;, 
Hard_to_Fill__c = False, 
Agency__c = True 
), 
AND(Tier_by_Ad_Spend__c = &quot;Tier 5&quot;, 
Job_Role_Classification__c = &quot;Primary&quot;, 
Agency__c = False 
), 

ISBLANK(Job_Role_Classification__c), 

AND(ISBLANK(Tier_by_Ad_Spend__c), 
Agency__c = True, 
Job_Role_Classification__c = &quot;Primary&quot; 
) 
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Vacancy Check In and Customer Care Call Dates</fullName>
        <actions>
            <name>Update_Check_in_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Customer_Care_Call_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Vacancy__c.Customer_Care_Call_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Vacancy__c.Check_In_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates the Vacancy Check In Call/Email Date and Customer Care Call Date when the Vacancy is created. Check In Date is midway through the ad&apos;s duration period and Customer Care Call Date is 6 weeks after the ad has expired. If a weekday, move to Monday.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Vacancy to Locked</fullName>
        <actions>
            <name>Update_Vacancy_to_Locked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Vacancy__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
