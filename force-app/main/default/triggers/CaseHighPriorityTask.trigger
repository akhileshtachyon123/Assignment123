trigger CaseHighPriorityTask on Case (before insert,after insert) 
{
      List<Task> TaskToCreate = new List<Task>();
      for(Case c: Trigger.new)
      {
          if(c.Priority=='High')
          {
              Task t = new task();
              t.Subject='Call Customer';
              t.WhatId=c.Id;
              t.OwnerId=c.OwnerId;
              t.Status='Not Started';
              t.Priority='High';
              taskToCreate.add(t);
          }
      }
    if(!taskToCreate.isEmpty())
    {
        Insert taskToCreate;
    }
}