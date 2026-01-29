Trigger DummyCaseTrigger01 on Case (before insert,before Update) 
{
if(Trigger.isbefore && (Trigger.isInsert || Trigger.isUpdate))
{
for(case c:Trigger.new)
{
    if(c.Priority=='High')
    {
        if((c.AccountId==''||c.AccountId==null))
        {
            c.addError('High Priority cases should be related to any Account');
        }
         if(c.ContactId==''||c.ContactId==NULL)
        {
            c.addError('High Priority cases should be related to any Contact');
        }
    }
}
}
}