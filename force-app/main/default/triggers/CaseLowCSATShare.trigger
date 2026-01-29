trigger CaseLowCSATShare on Case (before insert,after Update) 
{
     Id supportMgrRoleId = [
         Select Id From UserRole WHERE Name='Support Manager' limit 1
     ].Id;
     
    List<CaseShare> shares = new List<CaseShare>();
    for(Case c : Trigger.new)
    {
        Case Oldc = Trigger.OldMap.get(c.Id);
        if(!Oldc.IsClosed && c.Isclosed && c.CSAT_Score__c<=3)
        {
            shares.add(new CaseShare(
            CaseId=c.Id,
            UserOrGroupId = supportMgrRoleId,
            CaseAccessLevel = 'Read'
            ));
        }
    }
    if(!shares.isEmpty())
    {
        insert shares;
    }
}