trigger CaseAccountOpenCount on Case (before insert,after insert, after update, after delete, after undelete)
{
    set<Id> accountIds=new Set<Id>();
    
    if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete)
    {
        for(Case c : Trigger.new)
        {
            if(c.AccountId !=null)
            {
                accountIds.add(c.AccountId);
            }
        }
    }

    if(trigger.isDelete)
    {
        for(Case c: Trigger.old)
        {
            if(c.AccountId != null)
            {
                accountIds.add(c.AccountId);
            }
        }
    }

    if(accountIds.isEmpty())
    {
        return;
    }

    Map<Id, Integer> counts = new Map<Id, Integer>();

    for (AggregateResult ar : [
        SELECT AccountId accId, 
        COUNT(Id) cnt
        FROM Case
        WHERE IsClosed = false AND AccountId IN :accountIds
        GROUP BY AccountId
    ]) 
    {
        counts.put((Id)ar.get('accId'), (Integer)ar.get('cnt'));
    }

    List<Account> updates = new List<Account>();
    for (Id accId : accountIds) 
    {
        updates.add(new Account(
        Id = accId, 
        Open_Case_Count__c = counts.containsKey(accId) ? counts.get(accId) : 0));
    }

    update updates;
}