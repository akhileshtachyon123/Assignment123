trigger OpportunityCreateTask on Opportunity (After insert) 
{
     List<Task> tasks = new List<task>();
    for(Opportunity opp: Trigger.new)
    {
        tasks.add(new task(
        Subject = 'Follow up with customer',
        WhatId = opp.Id,
        OwnerId = opp.OwnerId,
        Status = 'Not Started',
        Priority = 'Normal'
        ));
    }
    Insert tasks;
}