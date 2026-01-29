trigger AccountTrigger1 on Account (before insert) 
{

    if(Trigger.isBefore && Trigger.isInsert)
    {
        for(Account acc:Trigger.new)
        {
            if(acc.Industry==Null || acc.Industry=='' )
            {
                acc.Industry.addError('Industry field cannot be blank');
            }
            else if(acc.Rating==Null || acc.Rating=='')
            {
             acc.Rating.addError('Rating field cannot be blank');   
            }
            else if(acc.fax==Null || acc.fax=='')
            {
                acc.Fax.addError('fax field cannot be blank');
            }
        }
    }
}