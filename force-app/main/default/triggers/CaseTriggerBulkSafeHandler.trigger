trigger CaseTriggerBulkSafeHandler on Case (before insert,before update,after insert,after update)
{
        if (Trigger.isBefore) 
        {
            if (Trigger.isInsert) 
            {
                CaseBulksafeTriggerHandler.beforeInsert(Trigger.new);
            }
            if (Trigger.isUpdate) 
            {
                CaseBulksafeTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
            }
        }

        if (Trigger.isAfter) 
        {
            if (Trigger.isInsert) 
            {
                CaseBulksafeTriggerHandler.afterInsert(Trigger.new);
            }
            if (Trigger.isUpdate) 
            {
                CaseBulksafeTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
            }
        }
}