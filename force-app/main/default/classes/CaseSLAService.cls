public with sharing class CaseSLAService 
{
    public static void applySLA(List<Case> casesList)
    {
        Case_SLA_Config__c sla = Case_SLA_Config__c.getInstance();
        if(sla==null || sla.Response_Hours__c==null)
        {
            return;
        }
        Integer slaHours = Integer.valueOf(sla.Response_Hours__c);
        for (Case c : casesList)
        {
            if(c.First_Response_Due__c==null)
            {
                 c.First_Response_Due__c = System.now().addHours(slaHours);
            }
            if(System.now()>c.First_Response_Due__c)
            {
                c.addError('SLA breached.Case cannot be saved');
            }
        }
    }
}