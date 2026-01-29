trigger CasePriorityHistory1 on Case (after Update) 
{
     List<Case_Priority_History__c> history = new List<Case_Priority_History__c>();

    for (Case c : Trigger.new) {
        Case oldC = Trigger.oldMap.get(c.Id);

        if ((oldC.Priority == 'Low' || oldC.Priority == 'Medium')
            && c.Priority == 'High') {

            history.add(new Case_Priority_History__c(
                Name=c.Id,
                Case__c = c.Id,
                Old_Priority__c = oldC.Priority,
                New_Priority__c = c.Priority
            ));
        }
    }

    if (!history.isEmpty()) 
    {
        insert history;
    }
}