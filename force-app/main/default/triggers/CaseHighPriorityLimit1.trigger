trigger CaseHighPriorityLimit1 on Case (before update) 
{

     Support_Policy__c policy = Support_Policy__c.getOrgDefaults();

     if (policy == null || policy.Max_High_Priority_Cases__c == null) 
     {
           return;
     }

     Integer limit1 = policy.Max_high_Priority_Cases__c.intValue();
 
   
    

    
    Set<Id> ownerIds = new Set<Id>();
    for (Case c : Trigger.new) 
    {
        ownerIds.add(c.OwnerId);
    }

    
    Map<Id, Integer> userCounts = new Map<Id, Integer>();

    for (AggregateResult ar : [
        SELECT OwnerId ownerId, COUNT(Id) total
        FROM Case
        WHERE Priority = 'High'
          AND IsClosed = false
          AND OwnerId IN :ownerIds
        GROUP BY OwnerId
    ]) 
    {
        userCounts.put(
            (Id) ar.get('ownerId'),
            (Integer) ar.get('total'));
    }

    
    for (Case c : Trigger.new) {

        Case oldC = Trigger.oldMap.get(c.Id);

        
        Boolean becomingHigh =
            c.Priority == 'High' && oldC.Priority != 'High';

        Boolean ownerChanged =
            c.OwnerId != oldC.OwnerId && c.Priority == 'High';

        if (becomingHigh || ownerChanged) 
        {

            Integer currentCount = userCounts.containsKey(c.OwnerId) ? userCounts.get(c.OwnerId): 0;
            if (currentCount >= limit1) 
            {
                c.addError('User has exceeded the maximum number of High Priority Cases.');
            }
        }
    }
}