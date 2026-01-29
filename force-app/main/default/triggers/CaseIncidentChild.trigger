trigger CaseIncidentChild on Case (after insert) 
{
    List<Case> children = new List<Case>();
    for(Case c : trigger.new)
    {
        if(c.Type=='Incident')
        {
            children.add(new Case(
            ParentId=c.Id,
            Subject='Root Cause Analysis',
            Status='New'
            ));
        }
    }
    if(!children.isEmpty())
    {
        insert children;
    }
}