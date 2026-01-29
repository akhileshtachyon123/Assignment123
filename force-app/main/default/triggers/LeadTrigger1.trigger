trigger LeadTrigger1 on Lead (before insert,before update) 
{
      if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
      {
         for(Lead ld:Trigger.new)
         {
             if(ld.Industry=='Banking')
             {
                 if(ld.Phone==Null || ld.Email=='')
                 {
                    ld.addError('Phone Field and Email field should not be blank');
                 }   
             }
          }
        }   
      
      
}