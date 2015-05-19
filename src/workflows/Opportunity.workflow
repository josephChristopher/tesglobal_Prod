<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_Account_on_Stop</fullName>
        <ccEmails>daisy.recto@cloudreach.co.uk</ccEmails>
        <description>Email Alert: Account on Stop</description>
        <protected>false</protected>
        <recipients>
            <recipient>drecto@tesglobal.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TES_Booking/Account_on_Stop_Email</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_TES_Direct_Recruitment_Email_Received</fullName>
        <description>Email Alert: TES Direct Recruitment Email Received</description>
        <protected>false</protected>
        <recipients>
            <field>Order_By_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TES_Booking/TESRecruitment_Email_Received_Alert</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_TES_Intl_Email_Received</fullName>
        <description>Email Alert: TES Intl Email Received</description>
        <protected>false</protected>
        <recipients>
            <field>Order_By_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>TES_Booking/TES_International_Email_Received_Alert</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Booking_Name_when_Booked</fullName>
        <field>Name</field>
        <formula>Account.Name &amp; &quot;: &quot; &amp; Ad_Number__c</formula>
        <name>Update Booking Name when Booked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Close_Date</fullName>
        <field>CloseDate</field>
        <formula>today()</formula>
        <name>Update Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Created_Date_Time</fullName>
        <field>Created_Date_Time__c</field>
        <formula>now()</formula>
        <name>Update Created Date/Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_Status_to_Account_on_Stop</fullName>
        <field>Email_Status__c</field>
        <literalValue>Account on Stop</literalValue>
        <name>Update Email Status to Account on Stop</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_Status_to_Awaiting_Booking</fullName>
        <field>Email_Status__c</field>
        <literalValue>Awaiting Booking</literalValue>
        <name>Update Email Status to Awaiting Booking</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_Status_to_Booked</fullName>
        <field>Email_Status__c</field>
        <literalValue>Booked</literalValue>
        <name>Update to Email Status to Booked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_Status_to_Query</fullName>
        <field>Email_Status__c</field>
        <literalValue>Query</literalValue>
        <name>Update Email Status to Query</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Leadership_FE_to_TRUE</fullName>
        <field>Leadership_FE__c</field>
        <literalValue>1</literalValue>
        <name>Update Leadership/FE to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Online_Job_Type_to_Bronze</fullName>
        <field>Online_Job_Type__c</field>
        <literalValue>Bronze</literalValue>
        <name>Update Online Job Type to Bronze</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Online_Job_Type_to_Gold</fullName>
        <field>Online_Job_Type__c</field>
        <literalValue>Gold</literalValue>
        <name>Update Online Job Type to Gold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Online_Job_Type_to_Silver</fullName>
        <field>Online_Job_Type__c</field>
        <literalValue>Silver</literalValue>
        <name>Update Online Job Type to Silver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Online_Job_Type_to_Starter</fullName>
        <field>Online_Job_Type__c</field>
        <literalValue>Starter</literalValue>
        <name>Update Online Job Type to Starter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Resolution_Time</fullName>
        <description>Updates the resolution time when a booking is booked into the system.</description>
        <field>Resolution_Time_Min__c</field>
        <formula>Elapsed_Time__c</formula>
        <name>Update Resolution Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Mac_Ad</fullName>
        <field>Space_Booking_or_Mac_Ad__c</field>
        <literalValue>Mac Ad</literalValue>
        <name>Update to Mac Ad</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_Space_Booking</fullName>
        <field>Space_Booking_or_Mac_Ad__c</field>
        <literalValue>Space Booking</literalValue>
        <name>Update to Space Booking</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email Alert%3A Account on Hold</fullName>
        <actions>
            <name>Email_Alert_Account_on_Stop</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Sends an email to Finance Team when a booking is received that is related to an Account on Hold.</description>
        <formula>CONTAINS(TEXT(Folder_Picklist__c), &quot;Account on Stop&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email Alert%3A TES Direct Recruitment Email Received</fullName>
        <actions>
            <name>Email_Alert_TES_Direct_Recruitment_Email_Received</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Mailbox_Picklist__c</field>
            <operation>equals</operation>
            <value>Direct - Recruitment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_Status__c</field>
            <operation>equals</operation>
            <value>Unread</value>
        </criteriaItems>
        <description>Sends an email confirmation to the client to acknowledge that their email has been received for TES Direct Recruitment bookings.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Email Alert%3A TES Intl Email Received</fullName>
        <actions>
            <name>Email_Alert_TES_Intl_Email_Received</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Mailbox_Picklist__c</field>
            <operation>equals</operation>
            <value>TES International</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Email_Status__c</field>
            <operation>equals</operation>
            <value>Unread</value>
        </criteriaItems>
        <description>Sends an email confirmation to the client to acknowledge that their email has been received for TES International bookings.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Booking Name%2C Email Status and Close Date when Booked</fullName>
        <actions>
            <name>Update_Booking_Name_when_Booked</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Email_Status_to_Booked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Ad_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update Booking Name, Email Status and Close Date when Booked</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Created Date and Time</fullName>
        <actions>
            <name>Update_Created_Date_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Created_Date_Time__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates Created Date/Time of a booking when the booking is created.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Email Status to Account on Stop</fullName>
        <actions>
            <name>Update_Email_Status_to_Account_on_Stop</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Email Status to Account on Stop when Folder contains &quot;Account on Stop&quot;</description>
        <formula>CONTAINS(Folder__r.Name, &quot;Account on Stop&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Email Status to Query</fullName>
        <actions>
            <name>Update_Email_Status_to_Query</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Email Status to Query if the email is actually a query.</description>
        <formula>CONTAINS(Folder__r.Name, &quot;Queries&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Email Status when Account is Out of Stop</fullName>
        <actions>
            <name>Update_Email_Status_to_Awaiting_Booking</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Email Status from Account on Stop to Awaiting Booking if Account for the Booking has been taken out of stop.</description>
        <formula>PRIORVALUE(Folder_Picklist__c) = &quot;Account on Stop&quot; &amp;&amp; 
ISBLANK(Ad_Number__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Leadership%2FFE to TRUE</fullName>
        <actions>
            <name>Update_Leadership_FE_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Leadership/FE to TRUE if the folder contains &quot;Leadership/FE&quot;.</description>
        <formula>AND(CONTAINS(Folder__r.Name, &quot;Leadership/FE&quot;),  Leadership_FE__c = FALSE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Online Job Type - Bronze</fullName>
        <actions>
            <name>Update_Online_Job_Type_to_Bronze</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Online Job Type to Bronze if the folder contains Bronze.</description>
        <formula>CONTAINS(Folder__r.Name, &quot;Bronze&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Online Job Type - Gold</fullName>
        <actions>
            <name>Update_Online_Job_Type_to_Gold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Online Job Type to Gold if the folder contains Gold.</description>
        <formula>CONTAINS(Folder__r.Name, &quot;Gold&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Online Job Type - Silver</fullName>
        <actions>
            <name>Update_Online_Job_Type_to_Silver</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Online Job Type to Silver if the folder contains Silver.</description>
        <formula>CONTAINS(Folder__r.Name, &quot;Silver&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Online Job Type - Starter</fullName>
        <actions>
            <name>Update_Online_Job_Type_to_Starter</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Online Job Type to Starter if the folder contains Starter.</description>
        <formula>CONTAINS(Folder__r.Name, &quot;Starter&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Resolution Time</fullName>
        <actions>
            <name>Update_Resolution_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Ad_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Resolution_Time_Min__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates Resolution Time when Booker populates the Ad Number and the Email Status changes to &quot;Booked&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Space Booking or Mac Ad to Mac Ad</fullName>
        <actions>
            <name>Update_to_Mac_Ad</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Space Booking or Mac Ad to Mac Ad if the folder contains &quot;Mac Ad&quot;.</description>
        <formula>CONTAINS(Folder__r.Name, &quot;Mac Ad&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Space Booking or Mac Ad to Space Booking</fullName>
        <actions>
            <name>Update_to_Space_Booking</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Space Booking or Mac Ad to Space Booking if the folder contains &quot;Space Booking&quot;.</description>
        <formula>OR(CONTAINS(Folder__r.Name, &quot;Space Booking&quot;), CONTAINS(Folder__r.Name, &quot;Sent to Artwork&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
