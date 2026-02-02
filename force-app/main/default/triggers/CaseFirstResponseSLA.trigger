trigger CaseFirstResponseSLA on Case (before insert) 
{
      
    Case_SLA_Config__c slaConfig = Case_SLA_Config__c.getInstance();

   
    if (slaConfig == null || slaConfig.Response_Hours__c == null) 
    {
        return;
    }

    Integer responseHours = Integer.valueOf(slaConfig.Response_Hours__c);

    for (Case c : Trigger.new) 
    {

        if (c.First_Response_Due__c == null) 
        {
            c.First_Response_Due__c = System.now().addHours(responseHours);
        }
    }
}
