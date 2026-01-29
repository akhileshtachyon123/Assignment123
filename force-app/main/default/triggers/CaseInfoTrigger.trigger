trigger CaseInfoTrigger on Case (before insert,before update) 
{
     CaseSensitiveInfoHelper.checkNotes(Trigger.New);
}