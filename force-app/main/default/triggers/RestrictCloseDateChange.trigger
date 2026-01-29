trigger RestrictCloseDateChange on Opportunity (before Update) 
{
     for(Opportunity opp : Trigger.new)
     {
         Opportunity oldopp = trigger.oldmap.get(opp.Id);
         if(oldopp.StageName=='Closed Won' && opp.StageName != 'Closed Won')
         {
             opp.CloseDate.addError('CloseDate cannot be changed after Closed Won');
         }
         
     }
}