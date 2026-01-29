trigger CaseDefaultOrigin on Case (before insert) 
{
   Case_Config__c config = Case_Config__c.getInstance('Default');
    
    if(config==null || config.Default_Origin__c=='')
    {
        return;
    }
    for(Case c : Trigger.new)
    {
        if(c.origin==null)
        {
            c.origin=config.Default_Origin__c;
        }
    }
}