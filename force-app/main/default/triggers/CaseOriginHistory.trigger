trigger CaseOriginHistory on Case (after Update) 
{
   List<Case_Origin_History__c> logs = new List<Case_Origin_History__c>();
    for(Case c : Trigger.new)
    {
        if(c.Origin != Trigger.OldMap.get(c.Id).Origin)
        {
            logs.add(new Case_Origin_History__c(
            Case__c = c.Id,
            New_Origin__c = c.Origin,
            Old_Origin__c = Trigger.OldMap.get(c.Id).Origin
            ));
        }
           
     }
    if(!logs.isEmpty())
    {
        insert logs;
    }
}