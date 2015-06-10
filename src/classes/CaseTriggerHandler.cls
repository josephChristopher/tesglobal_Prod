public with sharing class CaseTriggerHandler extends Reach.TriggerHandlerFactory {
	private final static Profile AMBASSADOR_PROFILE = [SELECT Id FROM Profile WHERE Name = 'Ambassador' LIMIT 1];
    private final static List<UserRole> SALES_MANAGER_ROLES = [SELECT Id FROM UserRole WHERE Name = 'Sales Manager' LIMIT 1];
    private final static User DEFAULT_OWNER_CUSTOMER_SUCCESS_CASE = [SELECT Id FROM User WHERE Name = 'Anthony Canning' LIMIT 1];
    private Id CUSTOMER_SUCCESS_RECORD_TYPE = Case.SObjectType.getDescribe().getRecordTypeInfosByName().get('Customer Success Case - Surveys').getRecordTypeId();
    private Id MARKET_SHARE_RECORD_TYPE = Case.SObjectType.getDescribe().getRecordTypeInfosByName().get('Market Share Case').getRecordTypeId();
    private Id MSL_BOOKING_RECORD_TYPE = Opportunity.SObjectType.getDescribe().getRecordTypeInfosByName().get('MSL Booking').getRecordTypeId();
    
    private Map<String, User> ambassadorsByRegion = new Map<String, User>();
    private Map<String, User> ambassadorSupervisorsByRegion = new Map<String, User>();
    private List<Case> mostRecentCaseWithSameAdNumber = new List<Case>();
    private String ambassadorId;
    private String ambassadorSpvrId;
    private List<regionUser> ambassadorUserList = new List<regionUser>();  
    private List<User> ambassadorUsers = new List<User>();
    private Set<Id> currentCaseTeamMembers = new Set<Id>();
    
    public override void beforeUpdate() {
        updateCSTCaseOwneronCheckIn(Trigger.New);        
        updateVisitDetailsOfSchoolsVisited(Trigger.New);
    }
    
    public override void beforeInsert() {
        getmostRecentCaseWithSameAdNumber(Trigger.New);
        updateCSTCaseOwneronPreCheckIn(Trigger.New);
        updateMarketShareCaseOwner(Trigger.New);
    }
    
    public override void afterInsert() {   
        
        updateBookingIfAdNumberUpdated((Map<Id, Case>)Trigger.newmap);
        updateBookingIfAdInsertUpdated((Map<Id, Case>)Trigger.newmap);
        createNewCaseTeamforMarketShareCase(Trigger.New, (Map<Id, Case>)Trigger.newmap);
    }
    
    public override void afterUpdate() {

        Map<Id, Case> casesWithUpdatedAdNumber = filterCasesWithUpdatedAdNumber((Map<Id, Case>)Trigger.oldmap, (Map<Id, Case>)Trigger.newmap);
        updateBookingIfAdNumberUpdated(casesWithUpdatedAdNumber);
        
        Map<Id, Case> casesWithUpdatedAdInsert = filterCasesWithUpdatedAdInsert((Map<Id, Case>)Trigger.oldmap, (Map<Id, Case>)Trigger.newmap);
        updateBookingIfAdInsertUpdated(casesWithUpdatedAdInsert);
        
        newCaseCallLog((Map<Id, Case>)Trigger.oldmap, (Map<Id, Case>)Trigger.newmap);
        updateAssignmentCountofCaseOwners(Trigger.Old, Trigger.New);
        
        createNewCaseTeamforMarketShareCase(Trigger.New, (Map<Id, Case>)Trigger.newmap);
    }
    
    
    //updates the owner of the Customer Success Case Record Type to the Cusomer Success Manager when Status is "Pre-Check In"
    private void updateCSTCaseOwneronPreCheckIn(List<Case> newRecords){
        
        for(Case newcase : newRecords){
            if(isCustomerSuccessCase(newcase) && newcase.Status == 'Pre-Check In'){
                newcase.OwnerId = DEFAULT_OWNER_CUSTOMER_SUCCESS_CASE.Id;
            }
        }
    }
    
    //updates the owner of the Customer Success Case Record Type when Status is updated to "Check In"
    private void updateCSTCaseOwneronCheckIn(List<Case> newRecords) {
    
        //position of the consultant on the Customer Success Consultant list    
        Integer position = 0;
        User consultant = null;
        
        List<Case> caseList = newRecords;
        List<User> customerSuccessConsultants = customerSuccessConsultants();
    
        //remove consultants that have a busy time log at this time
        removeBusyUsersfromList(customerSuccessConsultants);
        
        if(mostRecentCaseWithSameAdNumberExists()) {
            
            for(Case newcase : newRecords) {
            
                if (isCustomerSuccessCase(newcase) && newcase.Status == 'Check In' && newcase.Updated_CST_Owner__c == False) {
                        
                        newcase.OwnerId = mostRecentCaseWithSameAdNumber[0].OwnerId;
                        newcase.Updated_CST_Owner__c = True;
                }
            }
        
        } else {
                
                for(Case newcase : newRecords) {
                    
                   if (isCustomerSuccessCase(newcase) && newcase.Status == 'Check In' && newcase.Updated_CST_Owner__c == False) {
            
                        consultant = customerSuccessConsultants[position];
                        
                        if(consultant.RTF_Booking_Quota__c == null) {
                            consultant.RTF_Booking_Quota__c = 10;
                        }
                        if(consultant.Current_Booking_Count__c == null) {
                            consultant.Current_Booking_Count__c = 0;
                        }
                        
                        if((consultant.RTF_Booking_Quota__c - consultant.Current_Booking_Count__c) <=0) {
                            //find the next user.
                            Integer ctr = 0;
                            consultant = null;
                            for(User nUser : customerSuccessConsultants) {
                                if (ctr > position) {
                                    if(nUser.RTF_Booking_Quota__c == null) {
                                        nUser.RTF_Booking_Quota__c = 10;
                                    }
                                    if(nUser.Current_Booking_Count__c == null) {
                                        nUser.Current_Booking_Count__c = 0;
                                    }
                                    if((nUser.RTF_Booking_Quota__c - nUser.Current_Booking_Count__c) > 0) {
                                        consultant = nUser;
                                        position = ctr;
                                        break;
                                    }
                                }
                                ctr++;
                            }
                            if(consultant == null) {
                                position = 0;
                                consultant = customerSuccessConsultants[position];
                            }
                        }
                        
                        newcase.OwnerId = consultant.Id;
                        newcase.Updated_CST_Owner__c = True;
                        consultant.Current_Booking_Count__c = consultant.Current_Booking_Count__c+1;
                        position++;
                        if(position <= customerSuccessConsultants.size()) {
                            position = 0;
                        }
                        consultant = customerSuccessConsultants[position];
                            
                        }
                }
            }
        
                update customerSuccessConsultants;
        
    }

    //methods for updateCSTCaseOwneronCheckIn
    private List<User> customerSuccessConsultants(){
        
         List<User> customerSuccessConsultants = [SELECT Id, RTF_Booking_Quota__c, Current_Booking_Count__c
                                                  FROM User 
                                                  WHERE UserRole.Name = 'Customer Success Consultant'
                                                        and Profile.Name = 'Customer Success Consultant'
                                                        and On_Leave__c = False
                                                        and IsActive = TRUE
                                                  ORDER BY Quota_Current_Diff__c DESC];
        
        return customerSuccessConsultants;        
        
    }
    
    private Set<Id> setOfUserIdstoBeAllocated(List<User> usersToBeAllocated){
        
        Set<Id> setOfUserIdstoBeAllocated = new Set<Id>();
        
        for(User userToBeAllocated : usersToBeAllocated) {
            setOfUserIdstoBeAllocated.add(userToBeAllocated.Id);  
        }
        
        return setOfUserIdstoBeAllocated;
    
    }
    
    private void removeBusyUsersfromList(List<User> usersToBeAllocated) {
        
        Set<Id> customerConsultantIds = setOfUserIdstoBeAllocated(usersToBeAllocated);
        
        Busy_Time_Log__c[] timelog = [SELECT User__c, Date__c, End_Time__c, Start_Time__c FROM Busy_Time_Log__c
                                      WHERE User__c in :customerConsultantIds AND (Date__c = :System.today() OR Date__c = null)];
        
        for (Busy_Time_Log__c l : timeLog) {
            //only add the log if the current time is between the start and end times specified.
            String startTime = (String)l.Start_Time__c;
            String endTime = (String)l.End_Time__c;
            Datetime startDt = Datetime.newInstance(Date.today(), Time.newInstance(Integer.valueOf(startTime.substringBefore(':')), 
                                                                                   Integer.valueOf(startTime.substringAfter(':')),
                                                                                   0, 0));
            
            Datetime endDt = Datetime.newInstance(Date.today(), Time.newInstance(Integer.valueOf(endTime.substringBefore(':')),
                                                                                 Integer.valueOf(endTime.substringAfter(':')),
                                                                                 59, 999));
            Datetime nowDt = Datetime.now();
            if(nowDt >= startDt && nowDt <= endDt) {
                //this means that we are in the time period in which the user should be excluded from allocation
                Integer idx = -1;
                Integer ctr = 0;
                for(User userTobeAllocated : usersToBeAllocated) {
                    if(userTobeAllocated.Id == l.User__c) {
                        idx = ctr;
                        break;
                    }
                    ctr++;
                }
                if(idx >= 0) {
                    usersToBeAllocated.remove(idx);
                }   
            }
        }
    }
    
    private void getmostRecentCaseWithSameAdNumber(List<Case> newRecords){
        
        List<Id> caseVacancies = new List<Id>();
        List<String> caseAdNumbers = new List<String>();
        List<Vacancy__c> vacancyAdNumbers = new List<Vacancy__c>();
        
        for(Case newcase : newRecords) {      
            caseVacancies.add(newcase.Vacancy__c);
        }
        
        vacancyAdNumbers = [SELECT Id,Ad_Number__c FROM Vacancy__c WHERE Id =: caseVacancies ];
        
        for(Vacancy__c vacancy : vacancyAdNumbers) {
            caseAdNumbers.add(vacancy.Ad_Number__c);
        }
        
        mostRecentCaseWithSameAdNumber = [SELECT Id, Vacancy__r.Ad_Number__c, OwnerId 
                                     FROM Case
                                     WHERE Vacancy__r.Ad_Number__c =: caseAdNumbers
                                     AND Vacancy__r.Ad_Number__c != null
                                     AND Status != 'Pre-Check In'
                                     ORDER BY CreatedDate DESC
                                     LIMIT 1];
        
    }
    
    private Boolean mostRecentCaseWithSameAdNumberExists(){
        return mostRecentCaseWithSameAdNumber.size() > 0;
    }
   
    private Boolean isCustomerSuccessCase(Case aCase) {
        return aCase.RecordTypeId == CUSTOMER_SUCCESS_RECORD_TYPE;
    }
    
    //updates the Case Owner of the Market Share Case on a Round Robin Basis
    private void updateMarketShareCaseOwner(List<Case> newRecords){
    
        //position of the consultant on the Engagement Exec list    
        Integer position = 0;
        User engagementExec = null;
        
        List<Case> caseList = newRecords;
        List<User> engagementExecutives = engagementExecutives();
        
        //remove engagement executives that have a busy time log at this time
        removeBusyUsersfromList(engagementExecutives);
      
        for(Case newcase : newRecords) {
            
            if (isMarketShareCase(newcase)) {
                //get first user in the list
                engagementExec = engagementExecutives[position];
                
                if(engagementExec.RTF_Booking_Quota__c == null) {
                    engagementExec.RTF_Booking_Quota__c = 10;
                }
                if(engagementExec.Current_Booking_Count__c == null) {
                    engagementExec.Current_Booking_Count__c = 0;
                }
                
                if((engagementExec.RTF_Booking_Quota__c - engagementExec.Current_Booking_Count__c) <=0) {
                    //find the next user.
                    Integer ctr = 0;
                    engagementExec = null;
                    for(User nUser : engagementExecutives) {
                        if (ctr > position) {
                            if(nUser.RTF_Booking_Quota__c == null) {
                                nUser.RTF_Booking_Quota__c = 10;
                            }
                            if(nUser.Current_Booking_Count__c == null) {
                                nUser.Current_Booking_Count__c = 0;
                            }
                            if((nUser.RTF_Booking_Quota__c - nUser.Current_Booking_Count__c) > 0) {
                                engagementExec = nUser;
                                position = ctr;
                                break;
                            }
                        }
                        ctr++;
                    }
                    if(engagementExec == null) {
                        position = 0;
                        engagementExec = engagementExecutives[position];
                    }
                }
                
                newcase.OwnerId = engagementExec.Id;
                newcase.Updated_CST_Owner__c = True;
                engagementExec.Current_Booking_Count__c = engagementExec.Current_Booking_Count__c+1;
                position++;
                if(position <= engagementExecutives.size()) {
                    position = 0;
                }
                engagementExec = engagementExecutives[position];
                    
                }
        }
        
         update engagementExecutives;
            
    }

    
    //methods for updateMarketShareCaseOwner
    private List<User> engagementExecutives(){
        
        List<User> engagementExecutives = [SELECT Id,
                            RTF_Booking_Quota__c,
                            Current_Booking_Count__c
                            FROM User WHERE UserRole.Name = 'Engagement Executive'
                            and Profile.Name = 'Engagement Executive'
                            and On_Leave__c = False
                            and IsActive = TRUE
                            ORDER BY Quota_Current_Diff__c DESC];
        
        return engagementExecutives;
        
    }
    
    //updates the record assignment count of users that are allocated cases
    private void updateAssignmentCountofCaseOwners(List<Case> oldRecords, List<Case> newRecords){
        Set<Id> setofCaseOwnerIds = setofCaseOwnerIds(oldRecords, newRecords);
        List<AggregateResult> casesCountedinAssignmentCount = casesCountedinAssignmentCount(setofCaseOwnerIds);
        Set<Id> casesOwnerIdsCountedinAssignmentCount = casesOwnerIdsCountedinAssignmentCount(casesCountedinAssignmentCount);
        Map<Id, integer> caseOwnerCounter = caseOwnerCounter(casesCountedinAssignmentCount);
    
        List<User> caseOwnersToBeUpdated = [SELECT Id, Current_Booking_Count__c, RTF_Booking_Quota__c from User where Id in :casesOwnerIdsCountedinAssignmentCount];
        
        for(User caseOwner : caseOwnersToBeUpdated) {
            Integer numCases = caseOwnerCounter.get(caseOwner.Id);
            if(caseOwner.RTF_Booking_Quota__c == null) {
                caseOwner.RTF_Booking_Quota__c = 10;
            }
            if(numCases > 0) {
                caseOwner.Current_Booking_Count__c = numCases;
            }
        }
        update caseOwnersToBeUpdated;
    }
    
    private Set<Id> setofCaseOwnerIds (List<Case> oldRecords, List<Case> newRecords){
        
        Set<Id> setofCaseOwnerIds = new Set<Id>();
        Map<Id, Case> newCaseMap = new Map<Id, Case>();
        
        for(Case newcase: newRecords) {
            if(isCustomerSuccessCase(newcase) || isMarketShareCase(newcase)) {
                setofCaseOwnerIds.add(newcase.OwnerId);
                newCaseMap.put(newcase.Id, newcase);
            }
        }
        
        for(Case oldCase: oldRecords) {
            if(isCustomerSuccessCase(oldCase) || isMarketShareCase(oldCase)) {
                Case newCase = newCaseMap.get(oldCase.Id);
                if(newCase.OwnerId != oldCase.OwnerId){
                    setofCaseOwnerIds.add(oldCase.OwnerId);
                }
            }
        }
        
        return setofCaseOwnerIds;
    }
    
    private List<AggregateResult> casesCountedinAssignmentCount(Set<Id> setofCaseOwnerIds){
        
        List<AggregateResult> casesCountedinAssignmentCount = [SELECT OwnerId, count(Id) 
                                                               FROM Case 
                                                               WHERE Status_Custom__c NOT IN ('Email Complete','Call Complete', 'Incomplete', 'Awaiting Visit', 'Visit Complete', 'Awaiting Contact', 'In Progress', 'Closed - Resolved, Awaiting Booking', 'Closed - Resolved, No Booking', 'Closed - Not Resolved')
                                                               AND OwnerId in :setofCaseOwnerIds
                                                               GROUP BY OwnerId];
        
        return casesCountedinAssignmentCount;
    }
        
    private Set<Id> casesOwnerIdsCountedinAssignmentCount(List<AggregateResult> casesCountedinAssignmentCount) {
        Set<Id> casesOwnerIdsCountedinAssignmentCount = new Set<Id>();
        
        for(AggregateResult aCase : casesCountedinAssignmentCount) {
            casesOwnerIdsCountedinAssignmentCount.add((Id)aCase.get('OwnerId'));
        }
        
        return casesOwnerIdsCountedinAssignmentCount;
    }
    
    private Map<Id, Integer> caseOwnerCounter(List<AggregateResult> casesCountedinAssignmentCount){
        Map<Id, integer> caseOwnerCounter = new Map<Id,Integer>();
        
        for(AggregateResult aCase : casesCountedinAssignmentCount) {
            caseOwnerCounter.put((Id)aCase.get('OwnerId'),(Integer)aCase.get('expr0'));
        }
        
        return caseOwnerCounter;
    }
    
    //creates a new record in the Call_Log__c object with the Stage and Status fields of the Case when they are updated
    private void newCaseCallLog(Map<Id, Case> oldRecords, Map<Id, Case> newRecords){
        
        List<Call_Log__c> newCallLogs = new List<Call_Log__c>();
        
        for (Case newRecord : newRecords.values()) {
            Case oldRecord = oldRecords.get(newRecord.Id);
        
            if((stageIsChanged(oldRecord, newRecord) || statusIsChanged(oldRecord, newRecord)) && !Validator_cls.hasAlreadyDone()
              && (isCustomerSuccessCase(newRecord) || isMarketShareCase(newRecord))) {
                   
                   Call_Log__c callLog = new Call_Log__c();
                   
                   callLog.Call_Date_Time__c = system.now();
                   callLog.Old_Stage__c = oldRecord.Status;
                   callLog.Stage__c = newRecord.Status;
                   callLog.Old_Status__c = oldRecord.Status_Custom__c;
                   callLog.Status__c = newRecord.Status_Custom__c;
                   callLog.Case__c = newRecord.Id;
                   
                   newCallLogs.add(callLog);
                   
                   Validator_cls.setAlreadyDone();
                   
               }
        }
        
        insert newCallLogs;
    }
    
    //methods for newCaseCallLog
    private Boolean stageIsChanged(Case oldRecord, Case newRecord){
        return oldRecord.Status != newRecord.Status;
    }
    
    private Boolean statusIsChanged(Case oldRecord, Case newRecord){
        return oldRecord.Status_Custom__c != newRecord.Status_Custom__c;
    }
    
    private Boolean isMarketShareCase(Case newRecord) {
        return newRecord.RecordTypeId == MARKET_SHARE_RECORD_TYPE;
    }
    
    
    //updates the visit details of schools that are scheduled to be visited and have been visited by an Ambassador, i.e. cases with Status is "Awaiting Visit" or "Visit Complete"
    private void updateVisitDetailsOfSchoolsVisited(List<Case> newRecords){
        
        List<String> visitedSchoolIds = new List<String>();
        List<Organisation__c> listofSchoolsVisited = new List<Organisation__c>();
        
        for(Case newCase: newRecords){
             if(isMarketShareCase(newCase) && newCase.Status_Custom__c == 'Visit Complete') {
               visitedSchoolIds.add(newCase.SD_Name__c);
             }
        }
        
        listofSchoolsVisited = [SELECT Id, Visited_by_Ambassador__c FROM Organisation__c WHERE Id =: visitedSchoolIds AND Visited_by_Ambassador__c = FALSE LIMIT 1];
        
        for(Organisation__c visitedSchool : listofSchoolsVisited) {
            visitedSchool.Visited_by_Ambassador__c = True;
            visitedSchool.Date_Visited_by_Ambassador__c = system.today();
        }
        
        update listofSchoolsVisited;
    }
    
    //creates a new team member for market share cases depending on the Allocated Region
    private void createNewCaseTeamforMarketShareCase(List<Case> newRecords, Map<Id, Case> newRecordsMap){
        assignUsersinMapbyRegion();
        newCaseTeamMembers(newRecordsMap);
    }
    
    private Set<Id> currentCaseTeamMembers(Map<Id, Case> newRecords){
    
        List<String> marketShareCaseIds = new List<String>();
        List<CaseTeamMember> currentCaseTeamMembersList = new List<CaseTeamMember>();
        Set<Id> currentCaseTeamMembers = new Set<Id>();
                
        for(Case newCase: newRecords.values()) {
            if(isMarketShareCase(newCase)) {
                marketShareCaseIds.add(newCase.Id);  
            }
        }
    
        currentCaseTeamMembersList = [SELECT Id, ParentId, MemberId FROM CaseTeamMember WHERE ParentId =: marketShareCaseIds];
        
        for(CaseTeamMember ctm : currentCaseTeamMembersList){
            currentCaseTeamMembers.add(ctm.MemberId);            
        }        
        
        return currentCaseTeamMembers;       
        
    }
    
    public class regionUser {
        public Set<String> allocatedRegionList {get;set;}
        public User ambassador {get;set;}
        public Id ambassadorId {get;set;}
        
        public regionUser(User ambassador){
            String allocatedRegions = ambassador.Allocated_Region_Mkt_Share__c ;
            allocatedRegionList = new Set<String>(allocatedRegions.split(';'));
            ambassador = ambassador;
            ambassadorId = ambassador.Id;
        }
    }
    
    private List<regionUser> ambassadorUserList(){
        ambassadorUserList = new List<regionUser>();
        ambassadorUsers = new List<User>();
        List<User> ambassadorUsers = [SELECT Id, UserRoleId, Allocated_Region_Mkt_Share__c FROM User WHERE Allocated_Region_Mkt_Share__c != null AND ProfileId =: AMBASSADOR_PROFILE.Id];
        
        for(User u: ambassadorUsers ){
            ambassadorUserList.add(new regionUser(u));
        }
        
        system.debug('ambassadorUsers-->' + ambassadorUsers);
        system.debug('ambassadorUserList -->' + ambassadorUserList);
        
        return ambassadorUserList;
        
    }
    
    private void assignUsersinMapbyRegion() {
        List<User> usersWithAllocatedRegion = [SELECT Id, UserRoleId, Allocated_Region_Mkt_Share__c FROM User WHERE Allocated_Region_Mkt_Share__c != null];
    
        for(User user: usersWithAllocatedRegion) {
            
            if(isAmbassadorSupervisor(user, AmbassadorSupervisorRoles(SALES_MANAGER_ROLES))) {
            ambassadorSupervisorsByRegion.put(user.Allocated_Region_Mkt_Share__c, user);
            }
        }       
    }
    
    private void newCaseTeamMembers(Map<Id, Case> newRecords){
        List<CaseTeamMember> newCaseTeamMembers = new List<CaseTeamMember>();
        ambassadorUserList = ambassadorUserList();
        currentCaseTeamMembers = currentCaseTeamMembers(newRecords);
        
        for (Case newRecord : newRecords.values()) {
            if(isMarketShareCase(newRecord) && !currentCaseTeamMembers.contains(newRecord.OwnerId)){
            
                CaseTeamMember ctm = new CaseTeamMember();
                
                ctm.MemberId = newRecord.OwnerId;
                ctm.ParentId = newRecord.Id;
                //sandboxID --> 
                //ctm.TeamRoleId = '0B7m000000000AuCAI';
                //productionId -->
                ctm.TeamRoleId = '0B7w0000000Go7VCAS'; 
                
                newCaseTeamMembers.add(ctm);
            }
            
            if(isMarketShareCase(newRecord) && ambassadorUserList.size() > 0) {
                for(regionUser regionUser : ambassadorUserList){
                    if(regionUser.allocatedRegionList.contains(newRecord.Allocated_Region__c) && !currentCaseTeamMembers.contains(regionUser.ambassadorId)) {
                        CaseTeamMember ctm = new CaseTeamMember();
            
                        ctm.MemberId = regionUser.ambassadorId;
                        ctm.ParentId = newRecord.Id;
                        //sandboxID --> 
                        //ctm.TeamRoleId = '0B7m000000000ApCAI';
                        //productionId -->
                        ctm.TeamRoleId = '0B7w0000000Go7LCAS';
                        newCaseTeamMembers.add(ctm);
                    }
                }
            }
                
            if(isMarketShareCase(newRecord) && ambassadorSupervisorsByRegion.size() > 0 && containsMainAllocatedRegion(ambassadorSupervisorsByRegion, newRecord) && !currentCaseTeamMembers.contains(ambassadorSupervisorsByRegion.get(newRecord.Main_Allocated_Region__c).Id)) {
               
                CaseTeamMember ctm = new CaseTeamMember();
                
                ctm.MemberId = ambassadorSupervisorsByRegion.get(newRecord.Main_Allocated_Region__c).Id;
                ctm.ParentId = newRecord.Id;
                //sandboxID --> 
                //ctm.TeamRoleId = '0B7m000000000AzCAI'; 
                //productionId -->
                ctm.TeamRoleId = '0B7w0000000Go7QCAS'; 
                newCaseTeamMembers.add(ctm);
              
            }
        }
        
        if(newCaseTeamMembers.size() > 0) {
            insert newCaseTeamMembers;
        }
    }
    
    private Boolean containsMainAllocatedRegion(Map<String, User> usersByRegion, Case newCase){
        return usersByRegion.containsKey(newCase.Main_Allocated_Region__c);
    }
    
    
    private Set<Id> AmbassadorSupervisorRoles(List<UserRole> ambassadorSupervisorRoles){
        
        Set<Id> ambassadorSupervisorRoleIds = new Set<Id>();
        
        for(UserRole ambassadorRole: ambassadorSupervisorRoles) {
            ambassadorSupervisorRoleIds.add(ambassadorRole.id);
        }
        
        return ambassadorSupervisorRoleIds;
        
    }
    
    private Boolean isAmbassadorSupervisor(User aUser, Set<Id> roleIds){
        
        return roleIds.contains(aUser.UserRoleId);
        
    }
    
    
    //updates the booking of cases with an updated ad number
    private Map<Id, Case> filterCasesWithUpdatedAdNumber(Map<Id, Case> oldRecords, Map<Id, Case> newRecords) {
        Map<Id, Case> casesWithUpdatedAdNumber = new Map<Id, Case>();
        
        for (Case newRecord : newRecords.values()) {
            Case oldRecord = oldRecords.get(newRecord.Id);
            
            if (adNumberWasUpdated(oldRecord, newRecord))
                casesWithUpdatedAdNumber.put(newRecord.Id, newRecord);
        }
        
        return casesWithUpdatedAdNumber;
    }
    
    //updates the vacancy of cases with an updated ad insert
    private Map<Id, Case> filterCasesWithUpdatedAdInsert(Map<Id, Case> oldRecords, Map<Id, Case> newRecords) {
        Map<Id, Case> casesWithUpdatedAdInsert = new Map<Id, Case>();
        
        for (Case newRecord : newRecords.values()) {
            Case oldRecord = oldRecords.get(newRecord.Id);
            
            if (adInsertWasUpdated(oldRecord, newRecord))
                casesWithUpdatedAdInsert.put(newRecord.Id, newRecord);
        }
        
        return casesWithUpdatedAdInsert;
    }
    
    
    //updates the vacancy of the case when ad insert is updated
    private void updateBookingIfAdInsertUpdated(Map<Id, Case> newRecords) {
        
        List<Case> casesToUpdateVacancy = new List<Case>();
        List<String> allAdInsertsNeeded = new List<String>();
        
        for(Case newCase : newRecords.values()) {
            
            if (hasNoVacancy(newCase) && adInsertSet(newCase)) {
                casesToUpdateVacancy.add(new Case(Id=newCase.Id, Ad_Insert_Id__c = newCase.Ad_Insert_Id__c));
                allAdInsertsNeeded.add(newCase.Ad_Insert_Id__c);
            }
        }
        
        List<Vacancy__c> vacancies = [SELECT Id, Ad_Insert_MSL_ID__c FROM Vacancy__c WHERE Ad_Insert_MSL_ID__c != null AND Ad_Insert_MSL_ID__c IN :allAdInsertsNeeded];
        
        Map<String, Vacancy__c> vacanciesByAdInsert = getMapByAdInsert(vacancies);
        
        for(Case caseToUpdate : casesToUpdateVacancy) {
            
            Vacancy__c vc = vacanciesByAdInsert.get(caseToUpdate.Ad_Insert_Id__c);
            
            if(vc != null && vc.Id != null) {
                caseToUpdate.Vacancy__c = vc.Id;
            }
        }
        
        update casesToUpdateVacancy;
    }
    
    //methods for updateBookingIfAdInsertUpdated
    public Boolean adInsertWasUpdated(Case oldRecord, Case newRecord) {
        return oldRecord.Ad_Insert_Id__c != newRecord.Ad_Insert_Id__c;
    }
    
    private Map<String, Vacancy__c> getMapByAdInsert(List<Vacancy__c> vacancies) {
        Map<String, Vacancy__c> result = new Map<String, Vacancy__c>();
        
        for (Vacancy__c vc : vacancies)
            result.put(vc.Ad_Insert_MSL_ID__c , vc);
        
        return result;
        
    }

    private Boolean hasNoVacancy(Case aCase) {
        return aCase.Vacancy__c == null;
    }
    
    private Boolean adInsertSet(Case aCase) {
        return aCase.Ad_Insert_Id__c != null;
    }
    
    //updates the booking of the case when the ad number is updated
    private void updateBookingIfAdNumberUpdated(Map<Id, Case> newRecords) {
        
        List<Case> casesToUpdateBooking = new List<Case>();
        List<String> allAdNumbersNeeded = new List<String>();
        
        for (Case newCase : newRecords.values()) {
            
            
            if (hasNoBooking(newCase) && adNumberSet(newCase) && casesToUpdateBooking.isEmpty()) {
                casesToUpdateBooking.add(new Case(Id=newCase.Id, Ad_Number__c=newCase.Ad_number__c));
                allAdNumbersNeeded.add(newCase.Ad_Number__c);
            }
        }
        
         
        List<Opportunity> bookings = [SELECT Id, Ad_Number__c FROM Opportunity WHERE Ad_Number__c IN :allAdNumbersNeeded AND RecordTypeId =: MSL_BOOKING_RECORD_TYPE AND Ad_Number__c != null  LIMIT 1];
        
        system.debug('check bookings size' + bookings.size());
        
        Map<String, Opportunity> opportunitiesByAdNumber = getMapByAdNumber(bookings);
        
        for (Case caseToUpdate : casesToUpdateBooking) {
            
            Opportunity opp = opportunitiesByAdNumber.get(caseToUpdate.Ad_Number__c);           
            system.debug('check booking id' + opp);
            
            if(opp != null && opp.Id != null) {
                
                caseToUpdate.Booking__c = opp.Id; 
            }
            
        }
        
        if(casesToUpdateBooking.size() > 0) {
            update casesToUpdateBooking;
        }
        
    }
    
    //methods for updateBookingIfAdNumberUpdated
    public Boolean adNumberWasUpdated(Case oldRecord, Case newRecord) {
        return oldRecord.Ad_Number__c != newRecord.Ad_Number__c;
    }
    
    private Map<String, Opportunity> getMapByAdNumber(List<Opportunity> bookings) {
        Map<String, Opportunity> result = new Map<String, Opportunity>();
        
        for (Opportunity o : bookings) {
            if (bookings.size() > 0) {
                result.put(o.Ad_Number__c, o);
            }
        }
        return result;
    }
    
    private Boolean hasNoBooking(Case aCase) {
        return aCase.Booking__c == null;
    }
    
    private Boolean adNumberSet(Case aCase) {
        return aCase.Ad_Number__c != null;
    }
     
}