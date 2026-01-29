trigger OpportunityDiscountCreate on Opportunity (after insert) 
{
        List<discount__c> discounts = new List<discount__c>();
        for(Opportunity opp : Trigger.new)
        {
            if(opp.Amount > 50000)
            {
                discounts.add(new discount__c(
                Name=opp.Id+'dis1',
                opportunity__c=opp.Id,
                discount_Percent__c=5));
            }
        }
        if(!discounts.isEmpty())
        {
            insert discounts;
        }
}