<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>UpdateOrgPriorityToMedium</fullName>
        <field>Priority__c</field>
        <literalValue>3 - Medium</literalValue>
        <name>Update Org Priority to Medium</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Allocated_Region_for_Market_Share</fullName>
        <field>Mkt_Share_Allocated_Region__c</field>
        <formula>IF(OR(local_authority__r.Name = &apos;Bexley&apos;,
      local_authority__r.Name = &apos;Bromley&apos;,
      local_authority__r.Name = &apos;Croydon&apos;,
      local_authority__r.Name = &apos;Greenwich&apos;,
      local_authority__r.Name = &apos;Kingston Upon Thames&apos;,
      local_authority__r.Name = &apos;Lambeth&apos;,
      local_authority__r.Name = &apos;Lewisham&apos;,
      local_authority__r.Name = &apos;Merton&apos;,
      local_authority__r.Name = &apos;Richmond Upon Thames&apos;,
      local_authority__r.Name = &apos;Southwark&apos;,
      local_authority__r.Name = &apos;Sutton&apos;,
      local_authority__r.Name = &apos;Wandsworth&apos;,
      local_authority__r.Name = &apos;Hammersmith And Fulham&apos;,
      local_authority__r.Name = &apos;Kensington And Chelsea&apos;,
      local_authority__r.Name = &apos;Westminster&apos;,
      local_authority__r.Name = &apos;Reading&apos;,
      local_authority__r.Name = &apos;Slough&apos;,
      local_authority__r.Name = &apos;Windsor And Maidenhead&apos;,
      local_authority__r.Name = &apos;Wokingham&apos;
      ),
   &apos;South London&apos;,
IF(OR(local_authority__r.Name = &apos;Barking And Dagenham&apos;,
      local_authority__r.Name = &apos;Barnet&apos;,
      local_authority__r.Name = &apos;Brent&apos;,
      local_authority__r.Name = &apos;Camden&apos;,
      local_authority__r.Name = &apos;Ealing&apos;,
      local_authority__r.Name = &apos;Enfield&apos;,
      local_authority__r.Name = &apos;Hackney&apos;,
      local_authority__r.Name = &apos;Haringey&apos;,
      local_authority__r.Name = &apos;Harrow&apos;,
      local_authority__r.Name = &apos;Havering&apos;,
      local_authority__r.Name = &apos;Hillingdon&apos;,
      local_authority__r.Name = &apos;Hounslow&apos;,
      local_authority__r.Name  = &quot;Islington&quot;,
      local_authority__r.Name = &apos;Newham&apos;,
      local_authority__r.Name = &apos;Redbridge&apos;,
      local_authority__r.Name = &apos;Tower Hamlets&apos;,
      local_authority__r.Name = &apos;Waltham Forest&apos;
      ),
   &apos;North London&apos;,

IF(OR(local_authority__r.Name = &quot;Buckinghamshire&quot;, 
      local_authority__r.Name = &quot;Medway&quot;
      ),
   &apos;East of England&apos;,

IF(OR(local_authority__r.Name = &quot;Peterborough&quot;, 
      local_authority__r.Name = &quot;Doncaster&quot;,
      local_authority__r.Name = &quot;North East Lincolnshire&quot;,
      local_authority__r.Name = &quot;North Lincolnshire&quot;,
      local_authority__r.Name = &quot;Rotherham&quot;,
      local_authority__r.Name = &quot;Milton Keynes&quot;,
      local_authority__r.Name = &quot;Peterborough&quot;,
      local_authority__r.Name = &quot;Coventry&quot;
      ),
   &apos;East Midlands&apos;,

IF(OR(local_authority__r.Name = &quot;Oxfordshire&quot;, 
      local_authority__r.Name = &quot;West Berkshire&quot;
      ),
   &apos;South West&apos;,

IF(local_authority__r.Region__c  = &quot;Eastern&quot;, &quot;East of England&quot;,
IF(local_authority__r.Region__c = &quot;East Midlands&quot;, &quot;East Midlands&quot;,
IF(local_authority__r.Region__c = &quot;North West&quot;, &quot;North West&quot;,
IF(local_authority__r.Region__c = &quot;South East&quot;, &quot;South East&quot;,
IF(local_authority__r.Region__c = &quot;South West&quot;, &quot;South West&quot;,
IF(local_authority__r.Region__c = &quot;West Midlands&quot;, &quot;West Midlands&quot;,

IF(OR(local_authority__r.Region__c = &quot;North East&quot;, 
      local_authority__r.Region__c = &quot;Yorkshire And The Humber&quot;
      ),
   &apos;NE, Yorkshire And The Humber&apos;,

&quot;&quot;))))))))))))</formula>
        <name>Update Allocated Region for Market Share</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Org_Priority_to_High</fullName>
        <field>Priority__c</field>
        <literalValue>2 - High</literalValue>
        <name>Update Org Priority to High</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Org_Priority_to_Low</fullName>
        <field>Priority__c</field>
        <literalValue>4 - Low</literalValue>
        <name>Update Org Priority to Low</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Org_Priority_to_Very_High</fullName>
        <field>Priority__c</field>
        <literalValue>1 - Very High</literalValue>
        <name>Update Org Priority to Very High</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Org_Priority_to_Very_Low</fullName>
        <field>Priority__c</field>
        <literalValue>5 - Very Low</literalValue>
        <name>Update Org Priority to Very Low</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Phase_Text</fullName>
        <description>Updates phase text with the phase multi-select picklists</description>
        <field>Phase_Text__c</field>
        <formula>IF( 
INCLUDES(Phase__c, &quot;Early years&quot;), 
&quot;Early years, &quot;,&quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Primary&quot;), 
&quot;Primary, &quot;, &quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Middle&quot;), 
&quot;Middle, &quot;, &quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Secondary&quot;), 
&quot;Secondary, &quot;, &quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Sixth Form&quot;), 
&quot;Sixth Form, &quot;,&quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Further 16+&quot;), 
&quot;Further 16+, &quot;, &quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Further (Other)&quot;), 
&quot;Further (Other), &quot;, &quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Higher&quot;), 
&quot;Higher, &quot;, &quot;&quot;) 
&amp; 
IF( 
INCLUDES(Phase__c, &quot;Multi-Phase&quot;), 
&quot;Multi-Phase, &quot;, &quot;&quot;)</formula>
        <name>Update Phase Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Allocated Region</fullName>
        <actions>
            <name>Update_Allocated_Region_for_Market_Share</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the Allocated Region field on the Organisation when the Local Authority or GOR changes.</description>
        <formula>OR(NOT(ISBLANK(local_authority__c)),    NOT(ISNULL(local_authority__c)),    ISCHANGED( local_authority__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Org Priority to High based on Market Share Log</fullName>
        <actions>
            <name>Update_Org_Priority_to_High</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) OR (3 AND 4)</booleanFilter>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Reduced TES Share,Start share with others</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>greaterThan</operation>
            <value>10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Stopped using TES,100% TES to left TES</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>lessOrEqual</operation>
            <value>10</value>
        </criteriaItems>
        <description>Updates Org Priority to High based on most current Market Share Log.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Org Priority to Low based on Market Share Log</fullName>
        <actions>
            <name>Update_Org_Priority_to_Low</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) OR (3 AND 4) OR (5 AND 2) OR (5 AND 4)</booleanFilter>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Advertised this year but not last,Advertised this year but not last-new this week</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>greaterThan</operation>
            <value>10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Advertised TY only - Lost TES share WoW</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>lessOrEqual</operation>
            <value>10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>No advert YTD,Non-TES both years</value>
        </criteriaItems>
        <description>Updates Org Priority to Low based on most current Market Share Log.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Org Priority to Medium based on Market Share Log</fullName>
        <actions>
            <name>UpdateOrgPriorityToMedium</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 4) OR (2 AND 3)</booleanFilter>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Reduced TES Share,Start share with others</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>greaterThan</operation>
            <value>10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Advertised TY only - Lost TES share WoW</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>lessOrEqual</operation>
            <value>10</value>
        </criteriaItems>
        <description>Updates Org Priority to Medium based on most current Market Share Log.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Org Priority to Very High based on Market Share Log</fullName>
        <actions>
            <name>Update_Org_Priority_to_Very_High</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Stopped using TES,100% TES to left TES</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>greaterThan</operation>
            <value>10</value>
        </criteriaItems>
        <description>Updates Org Priority to Very High based on most current Market Share Log.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Org Priority to Very Low based on Market Share Log</fullName>
        <actions>
            <name>Update_Org_Priority_to_Very_Low</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 4) OR (3 AND 2)</booleanFilter>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Advertised this year but not last,Advertised this year but not last-new this week,Increased TES Share,100% TES both years</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>greaterThan</operation>
            <value>10</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Current_Movement_Category__c</field>
            <operation>equals</operation>
            <value>Increased TES Share,100% TES both years</value>
        </criteriaItems>
        <criteriaItems>
            <field>Organisation__c.Volumes_YTD__c</field>
            <operation>lessOrEqual</operation>
            <value>10</value>
        </criteriaItems>
        <description>Updates Org Priority to Very Low based on most current Market Share Log.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Phase Text</fullName>
        <actions>
            <name>Update_Phase_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Organisation__c.Phase__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the phase text field with the phase text multi-select picklist when it gets populated so that it can be used in a formula.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
