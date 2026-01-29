trigger DummyOpportunityTriggerDel on Opportunity (before insert,Before Update,before delete) 
{
/*if(trigger.isBefore && trigger.isUpdate)
{
    for(Opportunity opp:Trigger.New)
    {
        if(opp.StageName=='Closed Won')
        {
            opp.Probability=100;
            opp.Description='Congratulations'+opp.OwnerId+'We have won the opportunity';
            opp.CloseDate=Date.TODAY();
        }
    }
}*/
if(trigger.isBefore && trigger.isDelete)
{
    for(opportunity opp:Trigger.New)
    {
        if(opp.StageName=='Id.Decision Makers' || opp.StageName=='Perception Analysis' || opp.StageName=='Proposal/priceQuote' || opp.StageName=='Negotiation/Review')
        {
            opp.addError('You cant delete');
        }
    }
}
}