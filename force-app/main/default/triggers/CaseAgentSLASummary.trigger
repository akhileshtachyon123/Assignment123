trigger CaseAgentSLASummary on Case (after insert, after update, after delete, after undelete) 
{

    Set<Id> ownerIds = new Set<Id>();

  
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) 
    {
        for (Case c : Trigger.new) 
        {
            ownerIds.add(c.OwnerId);
        }
    }

    if (Trigger.isUpdate || Trigger.isDelete) 
    {
        for (Case c : Trigger.old) 
        {
            ownerIds.add(c.OwnerId);
        }
    }

    if (ownerIds.isEmpty()) return;

    
    Map<Id, Integer> openCasesMap = new Map<Id, Integer>();

    for (AggregateResult ar : [
        SELECT OwnerId ownerId, COUNT(Id) total
        FROM Case
        WHERE IsClosed = false
          AND OwnerId IN :ownerIds
        GROUP BY OwnerId
    ]) {
        openCasesMap.put(
            (Id) ar.get('ownerId'),
            (Integer) ar.get('total')
        );
    }

    
    Map<Id, Integer> breachedCasesMap = new Map<Id, Integer>();

    for (AggregateResult ar : [
        SELECT OwnerId ownerId, COUNT(Id) total
        FROM Case
        WHERE IsClosed = false
          AND SLA_Breached__c = true
          AND OwnerId IN :ownerIds
        GROUP BY OwnerId
    ]) {
        breachedCasesMap.put(
            (Id) ar.get('ownerId'),
            (Integer) ar.get('total')
        );
    }

    
    Map<Id, Agent_SLA_Summary__c> summaryMap =
        new Map<Id, Agent_SLA_Summary__c>();

    for (Agent_SLA_Summary__c s : [
        SELECT Id, Agent__c
        FROM Agent_SLA_Summary__c
        WHERE Agent__c IN :ownerIds
    ]) {
        summaryMap.put(s.Agent__c, s);
    }

  
    List<Agent_SLA_Summary__c> toUpsert =
        new List<Agent_SLA_Summary__c>();

    for (Id ownerId : ownerIds) {

        Integer openCnt =
            openCasesMap.containsKey(ownerId)
            ? openCasesMap.get(ownerId)
            : 0;

        Integer breachedCnt =
            breachedCasesMap.containsKey(ownerId)
            ? breachedCasesMap.get(ownerId)
            : 0;

        Agent_SLA_Summary__c summary;

        if (summaryMap.containsKey(ownerId)) 
        {
            summary = summaryMap.get(ownerId);
        } 
        else 
        {
            summary = new Agent_SLA_Summary__c(Agent__c = ownerId);
        }

        summary.Open_Cases__c = openCnt;
        summary.Cases_Breached__c = breachedCnt;

        toUpsert.add(summary);
    }

    if (!toUpsert.isEmpty()) 
    {
        upsert toUpsert;
    }
}