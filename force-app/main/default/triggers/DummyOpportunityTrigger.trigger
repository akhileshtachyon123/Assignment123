trigger DummyOpportunityTrigger on Opportunity (before insert) 
{
if(trigger.isBefore && trigger.isInsert)
{
    for(Opportunity opp:Trigger.new)
    {
        if(opp.Type==Null || opp.Type=='')
        {
            opp.Type.AddError('type should not be blank');
        }
    }
}

}