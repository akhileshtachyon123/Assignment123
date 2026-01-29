trigger dummyOpportunityTrigger1 on Opportunity (before insert) 
{
        if(Trigger.isBefore && Trigger.isInsert)
        {
            for(Opportunity opp:Trigger.new)
            {
                if(opp.Amount>1000000)
                {
                    opp.StageName='Closed Won';
                }
            }
        }
}