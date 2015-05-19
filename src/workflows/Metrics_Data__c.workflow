<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Customer_Care_Call_Date</fullName>
        <field>Customer_Care_Call_Date__c</field>
        <formula>CASE( 
MOD((DATEVALUE( Response__c )) - Date(1900, 1, 7), 7), 
0, (DATEVALUE( Response__c ))+1, 
1, (DATEVALUE( Response__c )), 
2, (DATEVALUE( Response__c )), 
3, (DATEVALUE( Response__c )), 
4, (DATEVALUE( Response__c )), 
5, (DATEVALUE( Response__c )), 
(DATEVALUE( Response__c ))+2 
)</formula>
        <name>Update Customer Care Call Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Customer_Effort_Score</fullName>
        <field>Customer_Effort_Score__c</field>
        <formula>IF(LEFT(Response__c, 4) = &quot;10 -&quot;, 10, 
IF(LEFT(Response__c, 3) = &quot;0 -&quot;, 0, 
VALUE( Response__c ) 
))</formula>
        <name>Update Customer Effort Score</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_NPS</fullName>
        <field>Net_Promoter_Score__c</field>
        <formula>IF(LEFT(Response__c, 4) = &quot;10 -&quot;, 10, 
IF(LEFT(Response__c, 3) = &quot;0 -&quot;, 0, 
VALUE( Response__c ) 
))</formula>
        <name>Update NPS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Rating_Score</fullName>
        <field>Rating__c</field>
        <formula>IF(LEFT(Response__c, 4) = &quot;10 -&quot;, 10,
IF(LEFT(Response__c, 3) = &quot;0 -&quot;, 0,
VALUE( Response__c )
))</formula>
        <name>Update Rating Score</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Response_Num</fullName>
        <field>Response_Num__c</field>
        <formula>VALUE( Response__c )</formula>
        <name>Update Response (Num)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Customer Care Call Date</fullName>
        <actions>
            <name>Update_Customer_Care_Call_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Metrics__c.Customer_Care_Call_Date__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Metrics_Data__c.Response__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Customer Effort Score</fullName>
        <actions>
            <name>Update_Customer_Effort_Score</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(CONTAINS(Metrics__r.Question__c, &quot;On a scale of 0 to 10, with 0 being extremely difficult and 10 being extremely easy, &quot;),  NOT(ISBLANK(Response__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Net Promoter Score</fullName>
        <actions>
            <name>Update_NPS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(CONTAINS(Metrics__r.Question__c, &quot;On a scale of 0 to 10, with 0 being definitely not recommend and 10 being definitely recommend&quot;),  NOT(ISBLANK(Response__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Rating Score</fullName>
        <actions>
            <name>Update_Rating_Score</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(CONTAINS(Metrics__r.Question__c, &quot;On a scale of 0 to 10&quot;),  NOT(ISBLANK(Response__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Response Numeric Value</fullName>
        <actions>
            <name>Update_Response_Num</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( ISPICKVAL( Metrics__r.Question_Format__c , &quot;Numeric Value&quot;), NOT(ISBLANK(Response__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
