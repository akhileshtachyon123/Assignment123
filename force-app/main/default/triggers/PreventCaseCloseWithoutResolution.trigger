trigger PreventCaseCloseWithoutResolution on Case (before insert,before Update) 
{
for(Case c : Trigger.new)
{
    Case oldcase=Trigger.oldMap.get(c.Id);

    if(c.Status=='Closed'&&oldcase.Status!='Closed')
    {
       if(c.Resolution__c=='')
       {
           c.addError('Resolution is required before closing the case');
       }
    }
}
}