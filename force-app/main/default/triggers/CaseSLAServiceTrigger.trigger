trigger CaseSLAServiceTrigger on Case (before insert,before update) 
{
   CaseSLAService.applySLA(Trigger.new);
}