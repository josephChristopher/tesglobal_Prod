<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Mid_Campaign_Check_In_Email_Alert</fullName>
        <ccEmails>cstsent@tesglobal.com</ccEmails>
        <description>Mid Campaign Check In Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderAddress>voc.noreply@tesglobal.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Customer_Success/Mid_Campaign_Check_In</template>
    </alerts>
    <fieldUpdates>
        <fullName>Time_Stamp_Call_Attempt_Date_1_to_Now</fullName>
        <field>Callback_Date__c</field>
        <formula>now()</formula>
        <name>Time Stamp Call Attempt Date 1 to Now</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamp_Customer_Care_Call_Attempt</fullName>
        <field>Customer_Care_Call_Attempt_Date_1__c</field>
        <formula>now()</formula>
        <name>Time Stamp Customer Care Call Attempt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamp_Date_Email_Sent</fullName>
        <field>Date_Email_Sent__c</field>
        <formula>TODAY()</formula>
        <name>Time Stamp Date Email Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamp_Date_Time_Closed</fullName>
        <field>DateTime_Closed__c</field>
        <formula>now()</formula>
        <name>Time Stamp Date/Time Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Time_Stamps_Date_Time_RA_Complate</fullName>
        <field>Date_Time_Remedial_Action_Complete__c</field>
        <formula>now()</formula>
        <name>Time Stamps Date/Time RA Complate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Ad_Web_Metrics_Complete</fullName>
        <field>Ad_Web_Metrics_Complete__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Ad Web Metrics Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Ad_Grade_to_Acceptable</fullName>
        <field>Ad_Performance_Grade__c</field>
        <literalValue>Acceptable</literalValue>
        <name>Update Ad Grade to Acceptable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Ad_Web_Grade_to_Sub_Optimal</fullName>
        <field>Ad_Performance_Grade__c</field>
        <literalValue>Sub-Optimal</literalValue>
        <name>Update Ad Web Grade to Sub Optimal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Origin_to_Email</fullName>
        <field>Origin</field>
        <literalValue>Email</literalValue>
        <name>Update Case Origin to Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Origin_to_Phone</fullName>
        <field>Origin</field>
        <literalValue>Phone</literalValue>
        <name>Update Case Origin to Phone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Owner_to_CST</fullName>
        <field>OwnerId</field>
        <lookupValue>Customer_Success_Team</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Case Owner to CST</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Owner_to_Customer_Services</fullName>
        <field>OwnerId</field>
        <lookupValue>Customer_Services_Team</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Case Owner to Customer Services</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Owner_to_Julia</fullName>
        <description>Updates Case Owner to Julia Rontree</description>
        <field>OwnerId</field>
        <lookupValue>julia.rontree@tesprime.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Update Case Owner to Julia</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Priority_to_High</fullName>
        <field>Priority</field>
        <literalValue>2 - High</literalValue>
        <name>Update Case Priority to High</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Priority_to_Low</fullName>
        <field>Priority</field>
        <literalValue>4 - Low</literalValue>
        <name>Update Case Priority to Low</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Priority_to_Medium</fullName>
        <field>Priority</field>
        <literalValue>3 - Medium</literalValue>
        <name>Update Case Priority to Medium</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Priority_to_Vacancy_Priority</fullName>
        <field>Priority</field>
        <literalValue>1 - Very High</literalValue>
        <name>Update Case Priority to Very High</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Status_to_Remedial_ActionReq</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Remedial Action Required</literalValue>
        <name>Update Case Status to Remedial ActionReq</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Check_In_Date_Time_Closed</fullName>
        <field>Check_In_Date_Time_Closed__c</field>
        <formula>NOW()</formula>
        <name>Update Check In Date/Time Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Closed_Date_to_Now</fullName>
        <field>Date_Time_Closed__c</field>
        <formula>now()</formula>
        <name>Update Closed Date to Now</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_High</fullName>
        <field>Priority</field>
        <literalValue>2 - High</literalValue>
        <name>Update Priority to High</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_Low</fullName>
        <field>Priority</field>
        <literalValue>4 - Low</literalValue>
        <name>Update Priority to Low</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_Medium</fullName>
        <field>Priority</field>
        <literalValue>3 - Medium</literalValue>
        <name>Update Priority to Medium</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Priority_to_Very_Low</fullName>
        <field>Priority</field>
        <literalValue>5 - Very Low</literalValue>
        <name>Update Priority to Very Low</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_to_CheckIn</fullName>
        <field>Status</field>
        <literalValue>Check In</literalValue>
        <name>Update Stage to Check In</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_to_Closed</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Update Stage to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_to_Customer_Care_Call</fullName>
        <field>Status</field>
        <literalValue>Customer Care Call</literalValue>
        <name>Update Stage to Customer Care Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Awaiting_Call</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Awaiting Call</literalValue>
        <name>Update Status to Awaiting Call</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Call_Scheduled</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Call Scheduled</literalValue>
        <name>Update Status to Call Scheduled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Email_Complete</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Email Complete</literalValue>
        <name>Update Status to Email Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Email_Scheduled</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Email Scheduled</literalValue>
        <name>Update Status to Email Scheduled.</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Email_Sent</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Email Sent</literalValue>
        <name>Update Status to Email Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Unresponsive_to_Email</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Unresponsive to Email</literalValue>
        <name>Update Status to Unresponsive to Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Call_Complete</fullName>
        <field>Status_Custom__c</field>
        <literalValue>Call Complete</literalValue>
        <name>Update to Call Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Reset Ad Web Metrics Complete</fullName>
        <actions>
            <name>Uncheck_Ad_Web_Metrics_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Customer Care Call</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time Stamp Check In Call Attempt Date 1 if Callback Required</fullName>
        <actions>
            <name>Time_Stamp_Call_Attempt_Date_1_to_Now</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Call Attempt 1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Check In</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Callback_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Time stamps &quot;Check In - Call Attempt Date 1&quot; with Today&apos;s Date/Time when user sets status to &quot;Call Attempt 1&quot; and Stage is &quot;Check In&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time Stamp Customer Care Call Attempt Date 1 if Callback Required and Customer Care Call</fullName>
        <actions>
            <name>Time_Stamp_Customer_Care_Call_Attempt</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Call Attempt 1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Customer Care Call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Customer_Care_Call_Attempt_Date_1__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Time stamps &quot;Customer Care - Call Attempt Date 1&quot; with Today&apos;s Date/Time when user sets status to &quot;Call Attempt 1&quot; and stage is &quot;Customer Care Call.&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time Stamp Customer Care Call Close Date%2FTime</fullName>
        <actions>
            <name>Update_Closed_Date_to_Now</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer Success Case - Surveys</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Call Complete,Remedial Action Required</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Customer Care Call</value>
        </criteriaItems>
        <description>Populates the Customer Care Call Completed Date/Time in case when the status is &quot;Call Complete&quot; and stage is &quot;Customer Care Call&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time Stamp Date Email Sent</fullName>
        <actions>
            <name>Time_Stamp_Date_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Email Sent</value>
        </criteriaItems>
        <description>Time stamps the date the email is sent.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time Stamp Date%2FTime Closed for Mkt Case</fullName>
        <actions>
            <name>Time_Stamp_Date_Time_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Market Share Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Solution Delivery</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>&quot;Closed - Resolved, Awaiting Booking&quot;,&quot;Closed - Resolved, No Booking&quot;,Closed - Not Resolved</value>
        </criteriaItems>
        <description>Time Stamps the Date/Time Closed for a Market Share Case when Cases is Closed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time Stamp Date%2FTime Remedial Action is Complete</fullName>
        <actions>
            <name>Time_Stamps_Date_Time_RA_Complate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Remedial Action Complete</value>
        </criteriaItems>
        <description>Time Stamps the Date/Time Remedial Action Complete to Now when case status is &quot;Remedial Action Complete&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Ad Web Grade to Acceptable</fullName>
        <actions>
            <name>Update_Ad_Grade_to_Acceptable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Job_Apply_Clicks__c</field>
            <operation>greaterOrEqual</operation>
            <value>10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Job_Views__c</field>
            <operation>greaterOrEqual</operation>
            <value>10</value>
        </criteriaItems>
        <description>Update Ad Web Grade to Acceptable if Ad Metrics &gt;= 10</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Origin to Email for Customer Success Surveys</fullName>
        <actions>
            <name>Update_Case_Origin_to_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Email Sent</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer Success Case - Surveys</value>
        </criteriaItems>
        <description>Updates Case Origin to Email for Cases for Customer Success Surveys if status is Email Sent</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Origin to Phone for Customer Success</fullName>
        <actions>
            <name>Update_Case_Origin_to_Phone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Awaiting Call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Customer Success Case - Surveys</value>
        </criteriaItems>
        <description>Updates Case Origin to Phone if Cases for Customer Survey has a status of Awaiting Call</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Owner to Customer Services Queue</fullName>
        <actions>
            <name>Update_Case_Owner_to_Customer_Services</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Queries</value>
        </criteriaItems>
        <description>Update Case Owner to Customer Services Queue if the case is a Query Record Type.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Owner to Customer Success Team</fullName>
        <actions>
            <name>Update_Case_Owner_to_CST</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Comments/Suggestions</value>
        </criteriaItems>
        <description>Update Case Owner to Customer Success Team Queue if the case is a Comments/Suggestion Record Type.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Owner to Julia Rontree</fullName>
        <actions>
            <name>Update_Case_Owner_to_Julia</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>contains</operation>
            <value>submitcase</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Complaints</value>
        </criteriaItems>
        <description>Updates Case Owner to Julia Rontree if it is a complaint coming from a Web Form.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Priority to High</fullName>
        <actions>
            <name>Update_Priority_to_High</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Main_Reason_for_Complaint__c</field>
            <operation>equals</operation>
            <value>Advert Cancelled,Advert Error</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subject_of_Enquiry__c</field>
            <operation>equals</operation>
            <value>Print Publication,Online Services,Specific Booking</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>notEqual</operation>
            <value>QMS</value>
        </criteriaItems>
        <description>Updates Case Priority to High if Main Reason for Complaint is Advert Cancelled or Advert Error.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Priority to High if Ad Metrics %3C 10</fullName>
        <actions>
            <name>Update_Ad_Web_Grade_to_Sub_Optimal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Case_Priority_to_High</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Case Priority to High if Ad Metrics &lt; 10 and Priority was Medium, Low and Very Low.</description>
        <formula>AND(OR(ISPICKVAL(Priority, &quot;3 - Medium&quot;),        ISPICKVAL(Priority, &quot;4 - Low&quot;),        ISPICKVAL(Priority, &quot;5 - Very Low&quot;)       ),      Job_Views__c &lt;10 )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Priority to Low</fullName>
        <actions>
            <name>Update_Priority_to_Low</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Case.Main_Reason_for_Complaint__c</field>
            <operation>equals</operation>
            <value>Discount/Upgrade Issue,Related to Customer Success Survey</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>QMS</value>
        </criteriaItems>
        <description>Updates Case Priority to Low if Main Reason for Complaint is Discount/Upgrade Issue or Related to Customer Success Survey.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Priority to Medium</fullName>
        <actions>
            <name>Update_Priority_to_Medium</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Main_Reason_for_Complaint__c</field>
            <operation>equals</operation>
            <value>Booking Error,Communication Issue,Duplicate Advert/Subscription,Invoice/Billing Issue,Pricing/Rating Issue,Other</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subject_of_Enquiry__c</field>
            <operation>equals</operation>
            <value>Other,General Enquiry</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>notEqual</operation>
            <value>QMS</value>
        </criteriaItems>
        <description>Updates Case Priority to Medium if Main Reason for Complaint is Booking Error, Communication Issue, Duplicate Advert/Subscription, Invoice/Billing Issue, Pricing/Rating Issue or Other.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Priority to Very High if Remedial Action Req</fullName>
        <actions>
            <name>Update_Case_Priority_to_Vacancy_Priority</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Case Priority to Very High if Status is Remedial Action Required</description>
        <formula>ISPICKVAL( Status_Custom__c , &quot;Remedial Action Required&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case to Check In - Awaiting Call</fullName>
        <actions>
            <name>Update_Stage_to_CheckIn</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_Awaiting_Call</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Case Stage to &quot;Check In&quot; and Case Status to &quot;Awaiting Call&quot; based on the Check In Call Date, Priority and Ad Metrics.</description>
        <formula>AND( Check_In_Call_Date__c = Today(),      OR(ISPICKVAL( Status, &quot;Pre-Check In&quot;),         AND(ISPICKVAL(Status, &quot;Check In&quot;),             ISPICKVAL(Status_Custom__c, &quot;Email Scheduled&quot;)             )         ),     OR (ISPICKVAL(Priority, &quot;1 - Very High&quot;),         ISPICKVAL(Priority, &quot;2 - High&quot;),         AND(OR(ISPICKVAL(Priority, &quot;3 - Medium&quot;),                ISPICKVAL(Priority, &quot;4 - Low&quot;),                ISPICKVAL(Priority, &quot;5 - Very Low&quot;)                ),             Job_Views__c &lt;10            )         )      )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case to Check In - Awaiting Call %28Time Based WF%29</fullName>
        <active>true</active>
        <description>Updates Case Stage to &quot;Check In&quot; and Case Status to &quot;Awaiting Call&quot; based on the Check In Call Date , Priority and Ad Metrics.</description>
        <formula>AND( Check_In_Call_Date__c &gt; Today(),  OR(ISPICKVAL( Status, &quot;Pre-Check In&quot;),  AND(ISPICKVAL(Status, &quot;Check In&quot;),  ISPICKVAL(Status_Custom__c, &quot;Email Scheduled&quot;)  )  ),  OR (ISPICKVAL(Priority, &quot;1 - Very High&quot;),  ISPICKVAL(Priority, &quot;2 - High&quot;),  AND(OR(ISPICKVAL(Priority, &quot;3 - Medium&quot;),  ISPICKVAL(Priority, &quot;4 - Low&quot;),  ISPICKVAL(Priority, &quot;5 - Very Low&quot;)  ),  Job_Views__c &lt;10 )  )  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Stage_to_CheckIn</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Update_Status_to_Awaiting_Call</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.Check_In_Call_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Case to Check In - Email Scheduled</fullName>
        <actions>
            <name>Update_Stage_to_CheckIn</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_Email_Scheduled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Case Stage to &quot;Check In&quot; and Case Status to &quot;Email Scheduled&quot; based on the Check In Call Date, Priority and Ad Metrics.</description>
        <formula>AND( Check_In_Call_Date__c = Today(),      ISPICKVAL( Status, &quot;Pre-Check In&quot;),     OR (ISPICKVAL(Priority, &quot;3 - Medium&quot;),         ISPICKVAL(Priority, &quot;4 - Low&quot;),         ISPICKVAL(Priority, &quot;5 - Very Low&quot;)        ),      ISBLANK(Job_Apply_Clicks__c),      ISBLANK(Job_Views__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case to Check In - Email Scheduled %28Time Based WF%29</fullName>
        <active>true</active>
        <description>Updates Case Stage to &quot;Check In&quot; and Case Status to &quot;Email Scheduled&quot; based on the Check In Call Date, Priority and Ad Metrics.</description>
        <formula>AND( Check_In_Call_Date__c &gt; Today(),      ISPICKVAL( Status, &quot;Pre-Check In&quot;),     OR (ISPICKVAL(Priority, &quot;3 - Medium&quot;),         ISPICKVAL(Priority, &quot;4 - Low&quot;),         ISPICKVAL(Priority, &quot;5 - Very Low&quot;)        ),      ISBLANK(Job_Apply_Clicks__c),      ISBLANK(Job_Views__c) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Stage_to_CheckIn</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Update_Status_to_Email_Scheduled</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.Check_In_Call_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Case to Check In - Email Sent</fullName>
        <actions>
            <name>Mid_Campaign_Check_In_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Stage_to_CheckIn</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Case Stage to &quot;Check In&quot; and Case Status to &quot;Email Sent&quot; based on the Check In Call Date, Priority and Ad Metrics.</description>
        <formula>AND( Check_In_Call_Date__c &lt;= Today(),      OR(ISPICKVAL( Status, &quot;Pre-Check In&quot;),         ISPICKVAL( Status, &quot;Check In&quot;)),     OR (ISPICKVAL(Priority, &quot;3 - Medium&quot;),         ISPICKVAL(Priority, &quot;4 - Low&quot;),         ISPICKVAL(Priority, &quot;5 - Very Low&quot;)        ),      Job_Views__c &gt;= 10,      NOT(ISBLANK( ContactId )),      NOT(ISBLANK(  Check_In_Survey_Link__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case to Check In - Email Sent %28Time-Based WF%29</fullName>
        <active>true</active>
        <description>Updates Case Stage to &quot;Check In&quot; and Case Status to &quot;Email Sent&quot; based on the Check In Call Date, Priority and Ad Metrics.</description>
        <formula>AND( Check_In_Call_Date__c &gt; Today(),      OR(ISPICKVAL( Status, &quot;Pre-Check In&quot;),         ISPICKVAL( Status, &quot;Check In&quot;)),     OR (ISPICKVAL(Priority, &quot;3 - Medium&quot;),         ISPICKVAL(Priority, &quot;4 - Low&quot;),         ISPICKVAL(Priority, &quot;5 - Very Low&quot;)        ),      Job_Views__c &gt;= 10,      NOT(ISBLANK( ContactId )),      NOT(ISBLANK(  Check_In_Survey_Link__c )) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Mid_Campaign_Check_In_Email_Alert</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Update_Stage_to_CheckIn</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Update_Status_to_Email_Sent</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.Check_In_Call_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Case to Customer Care Call - Awaiting Call</fullName>
        <actions>
            <name>Update_Stage_to_Customer_Care_Call</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_Awaiting_Call</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Case Stage to &quot;Customer Care Call&quot; and Case Status to &quot;Awaiting Call&quot; based on the Check In Call Date.</description>
        <formula>OR(AND( Customer_Care_Call_Date__c = Today(),  
     ISPICKVAL( Status, &quot;Check In&quot;),  
    OR(ISPICKVAL( Status_Custom__c , &quot;Email Complete&quot;),    
       ISPICKVAL( Status_Custom__c , &quot;Call Complete&quot;), 
       ISPICKVAL( Status_Custom__c , &quot;Incomplete&quot;) 
       )
   ),
  AND(Customer_Care_Call_Date__c = Today(), 
Check_In_Call_Date__c &lt; Today(), 
      ISPICKVAL( Status, &quot;Pre-Check In&quot;)
      )
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case to Customer Care Call - Awaiting Call %28Time Based WF%29</fullName>
        <active>true</active>
        <description>Updates Case Stage to &quot;Customer Care Call&quot; and Case Status to &quot;Awaiting Call&quot; based on the Customer Call Date.</description>
        <formula>OR(AND( Customer_Care_Call_Date__c &gt; Today(),  
     ISPICKVAL( Status, &quot;Check In&quot;),  
    OR(ISPICKVAL( Status_Custom__c , &quot;Email Complete&quot;),    
       ISPICKVAL( Status_Custom__c , &quot;Call Complete&quot;), 
       ISPICKVAL( Status_Custom__c , &quot;Incomplete&quot;) 
       )
   ),
  AND(Customer_Care_Call_Date__c &gt; Today(), 
Check_In_Call_Date__c &lt; Today(), 
      ISPICKVAL( Status, &quot;Pre-Check In&quot;)
      )
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Stage_to_Customer_Care_Call</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Update_Status_to_Awaiting_Call</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.Customer_Care_Call_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Check In Date%2FTime Closed When Check In is Complete</fullName>
        <actions>
            <name>Update_Check_In_Date_Time_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status_Custom__c</field>
            <operation>equals</operation>
            <value>Call Complete,Email Complete,Remedial Action Required</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Check In</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Date%2FTime Closed for Non Survey Related Cases</fullName>
        <actions>
            <name>Time_Stamp_Date_Time_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Case Email,Comments/Suggestions,Complaints,Queries</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed,Closed - Resolved,Closed - No Resolution,Read</value>
        </criteriaItems>
        <description>Update Date/Time Closed for Cases with the following Record Types: Complaints, Queries, Case Emails and Comments.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status to Call Scheduled based on Priority</fullName>
        <actions>
            <name>Update_Status_to_Call_Scheduled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Case Status to Call Scheduled based on Priority if Stage is Pre-Check In.</description>
        <formula>AND(  ISPICKVAL(Status, &quot;Pre-Check In&quot;),     

OR(ISPICKVAL(Priority, &quot;1 - Very High&quot;),        
ISPICKVAL(Priority, &quot;2 - High&quot;),        

AND(OR(ISPICKVAL(Priority, &quot;3 - Medium&quot;),                ISPICKVAL(Priority, &quot;4 - Low&quot;),                
ISPICKVAL(Priority, &quot;5 - Very Low&quot;)),
Job_Views__c &lt;10                         )         ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status to Email Scheduled based on Priority</fullName>
        <actions>
            <name>Update_Status_to_Email_Scheduled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Case Status to Email Scheduled based on Priority if Stage is Pre-Check In.</description>
        <formula>AND( ISPICKVAL(Status, &quot;Pre-Check In&quot;), 
OR(ISPICKVAL(Priority, &quot;3 - Medium&quot;),    
ISPICKVAL(Priority, &quot;4 - Low&quot;),    
ISPICKVAL(Priority, &quot;5 - Very Low&quot;)    ), 

OR (Job_Views__c &gt;= 10, 
ISBLANK(Job_Views__c) )  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Status to Unresponsive to Email</fullName>
        <actions>
            <name>Update_Status_to_Unresponsive_to_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates status to Unresponsive to Email if survey is not completed a week after Status is set to Email Sent.</description>
        <formula>TODAY() -  Date_Email_Sent__c &gt; 7</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update to Call Complete</fullName>
        <actions>
            <name>Update_to_Call_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(AND(ISPICKVAL(Status, &quot;Check In&quot;), 
OR(ISPICKVAL( Status_Custom__c, &quot;Awaiting Call&quot; ), 
ISPICKVAL( Status_Custom__c, &quot;Call Attempt 1&quot;), 
ISPICKVAL( Status_Custom__c, &quot;Call Attempt 2&quot;), 
ISPICKVAL( Status_Custom__c, &quot;Call Attempt 3&quot;) 
), 
Survey_Count__c = 1, 
NOT(ISNULL(Mid_Campaign_Rating_Score__c)), 
Mid_Campaign_Rating_Score__c &gt; 6 
), 

AND(ISPICKVAL(Status, &quot;Customer Care Call&quot;), 
OR(ISPICKVAL( Status_Custom__c, &quot;Awaiting Call&quot; ), 
ISPICKVAL( Status_Custom__c, &quot;Call Attempt 1&quot;), 
ISPICKVAL( Status_Custom__c, &quot;Call Attempt 2&quot;), 
ISPICKVAL( Status_Custom__c, &quot;Call Attempt 3&quot;) 
), 
Survey_Count__c = 2, 
Post_Campaign_Rating_Score__c &gt; 6 
) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update to Email Complete</fullName>
        <actions>
            <name>Update_Status_to_Email_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(OR( ISPICKVAL( Status_Custom__c, &quot;Email Sent&quot;), 
ISPICKVAL( Status_Custom__c, &quot;Unresponsive to Email&quot;) 
), 
Survey_Count__c = 1, 
Lowest_Rating_Score__c &gt; 6 )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update to Remedial Action Required %26 Very High Priority</fullName>
        <actions>
            <name>Update_Case_Priority_to_Vacancy_Priority</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Case_Status_to_Remedial_ActionReq</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Case Status to Remedial Action Required &amp; Very High Priority when Lowest Rating Score is 6 or below.</description>
        <formula>OR(AND(OR( ISPICKVAL( Status_Custom__c, &quot;Email Sent&quot;), 
           ISPICKVAL( Status_Custom__c, &quot;Unresponsive to Email&quot;) 
          ), 
       Survey_Count__c = 1, 
       Lowest_Rating_Score__c &lt;= 6 
       ),

   AND(ISPICKVAL(Status, &quot;Check In&quot;),
       OR(ISPICKVAL( Status_Custom__c, &quot;Awaiting Call&quot; ), 
          ISPICKVAL( Status_Custom__c, &quot;Call Attempt 1&quot;), 
          ISPICKVAL( Status_Custom__c, &quot;Call Attempt 2&quot;), 
          ISPICKVAL( Status_Custom__c, &quot;Call Attempt 3&quot;) 
          ), 
       Survey_Count__c = 1,
       NOT(ISNULL(Mid_Campaign_Rating_Score__c)),
       Mid_Campaign_Rating_Score__c &lt;= 6 
      ),

   AND(ISPICKVAL(Status, &quot;Customer Care Call&quot;),
       OR(ISPICKVAL( Status_Custom__c, &quot;Awaiting Call&quot; ), 
          ISPICKVAL( Status_Custom__c, &quot;Call Attempt 1&quot;), 
          ISPICKVAL( Status_Custom__c, &quot;Call Attempt 2&quot;), 
          ISPICKVAL( Status_Custom__c, &quot;Call Attempt 3&quot;) 
          ), 
       Survey_Count__c = 2,
       Post_Campaign_Rating_Score__c &lt;= 6 
      )

)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
