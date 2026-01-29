trigger CaseVIPShare on Case (after insert) {

    Set<Id> accountIds = new Set<Id>();
    for (Case c : Trigger.new) {
        if (c.AccountId != null) accountIds.add(c.AccountId);
    }

    Map<Id, Account> accMap = new Map<Id, Account>(
        [SELECT Id, VIP__c FROM Account WHERE Id IN :accountIds]
    );

    Id csmRoleId = [
        SELECT Id FROM UserRole WHERE Name = 'Customer Success Manager' LIMIT 1
    ].Id;

    List<CaseShare> shares = new List<CaseShare>();

    for (Case c : Trigger.new) 
    {
        if (c.AccountId != null && accMap.get(c.AccountId).VIP__c) 
        {
            shares.add(new CaseShare(
                CaseId = c.Id,
                UserOrGroupId = csmRoleId,
                CaseAccessLevel = 'Read'
            ));
        }
    }

    if (!shares.isEmpty())
    {
        insert shares;
    }
}