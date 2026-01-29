trigger DummyHMTrigger01 on Hiring_Manger__c (before insert,before Update) 
{
if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
{
    for( Hiring_Manger__c hm:trigger.new)
    {
        if(hm.Location__c==NULL)
        {
            hm.addError('Location field cannot be Blank');
        }
    }
}
}