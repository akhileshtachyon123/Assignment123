trigger dummyLeadTrigger on Lead (before insert) 
{
     if(Trigger.isbefore && Trigger.isInsert)
     {
        for(Lead ld:Trigger.new)
        {
            if(ld.LeadSource=='Web')
            {
                ld.Rating='Cold';
            }
            else
            {
                ld.Rating='hot';
            }
        }
     }
}