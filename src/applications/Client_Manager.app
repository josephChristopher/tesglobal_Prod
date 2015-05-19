<?xml version="1.0" encoding="UTF-8"?>
<CustomApplication xmlns="http://soap.sforce.com/2006/04/metadata">
    <customApplicationComponents>
        <alignment>right</alignment>
        <customApplicationComponent>Console.BuiltInComponent.mostRecentlyUsed</customApplicationComponent>
    </customApplicationComponents>
    <defaultLandingTab>standard-home</defaultLandingTab>
    <description>The console used by the team responsible for creating accounts.</description>
    <detailPageRefreshMethod>autoRefresh</detailPageRefreshMethod>
    <enableKeyboardShortcuts>true</enableKeyboardShortcuts>
    <enableMultiMonitorComponents>true</enableMultiMonitorComponents>
    <isServiceCloudConsole>true</isServiceCloudConsole>
    <keyboardShortcuts>
        <defaultShortcut>
            <action>FOCUS_CONSOLE</action>
            <active>true</active>
            <keyCommand>ESC</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_NAVIGATOR_TAB</action>
            <active>true</active>
            <keyCommand>V</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_DETAIL_VIEW</action>
            <active>true</active>
            <keyCommand>SHIFT+S</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_PRIMARY_TAB_PANEL</action>
            <active>true</active>
            <keyCommand>P</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_SUBTAB_PANEL</action>
            <active>true</active>
            <keyCommand>S</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_LIST_VIEW</action>
            <active>true</active>
            <keyCommand>N</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_FIRST_LIST_VIEW</action>
            <active>true</active>
            <keyCommand>SHIFT+F</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_SEARCH_INPUT</action>
            <active>true</active>
            <keyCommand>R</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>MOVE_LEFT</action>
            <active>true</active>
            <keyCommand>LEFT ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>MOVE_RIGHT</action>
            <active>true</active>
            <keyCommand>RIGHT ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>UP_ARROW</action>
            <active>true</active>
            <keyCommand>UP ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>DOWN_ARROW</action>
            <active>true</active>
            <keyCommand>DOWN ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>OPEN_TAB_SCROLLER_MENU</action>
            <active>true</active>
            <keyCommand>D</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>OPEN_TAB</action>
            <active>true</active>
            <keyCommand>T</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>CLOSE_TAB</action>
            <active>true</active>
            <keyCommand>C</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>REFRESH_TAB</action>
            <active>false</active>
            <keyCommand>SHIFT+R</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>ENTER</action>
            <active>true</active>
            <keyCommand>ENTER</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>EDIT</action>
            <active>true</active>
            <keyCommand>E</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>SAVE</action>
            <active>true</active>
            <keyCommand>CTRL+S</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>CONSOLE_LINK_DIALOG</action>
            <active>false</active>
            <keyCommand>U</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>HOTKEYS_PANEL</action>
            <active>false</active>
            <keyCommand>SHIFT+K</keyCommand>
        </defaultShortcut>
    </keyboardShortcuts>
    <label>Client Manager</label>
    <listPlacement>
        <location>left</location>
        <units>percent</units>
        <width>50</width>
    </listPlacement>
    <listRefreshMethod>refreshList</listRefreshMethod>
    <logo>Logos_Icons/TES_Logo_Transparent.png</logo>
    <pushNotifications>
        <pushNotification>
            <fieldNames>Account</fieldNames>
            <fieldNames>Ad_Number__c</fieldNames>
            <fieldNames>Elapsed_Time_No_Bus_Hrs__c</fieldNames>
            <fieldNames>Email_Status__c</fieldNames>
            <fieldNames>Flag__c</fieldNames>
            <fieldNames>Folder__c</fieldNames>
            <fieldNames>Leadership_FE__c</fieldNames>
            <fieldNames>Mailbox__c</fieldNames>
            <fieldNames>Name</fieldNames>
            <fieldNames>Online_Job_Type__c</fieldNames>
            <fieldNames>Owner</fieldNames>
            <fieldNames>RecordType</fieldNames>
            <fieldNames>Resolution_Time_Min__c</fieldNames>
            <fieldNames>Space_Booking_or_Mac_Ad__c</fieldNames>
            <fieldNames>StageName</fieldNames>
            <fieldNames>Type</fieldNames>
            <objectName>Opportunity</objectName>
        </pushNotification>
    </pushNotifications>
    <saveUserSessions>true</saveUserSessions>
    <tab>standard-Lead</tab>
    <tab>standard-Account</tab>
    <workspaceMappings>
        <mapping>
            <tab>standard-Lead</tab>
        </mapping>
        <mapping>
            <tab>standard-Account</tab>
        </mapping>
    </workspaceMappings>
</CustomApplication>