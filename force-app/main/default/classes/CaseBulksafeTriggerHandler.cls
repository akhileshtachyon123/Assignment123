public class CaseBulksafeTriggerHandler 
{
      public static void beforeInsert(List<Case> newCases) 
      {
            for (Case c : newCases) 
            {
                if (c.First_Response_Due__c == null) 
                {
                   c.First_Response_Due__c = System.now().addHours(4);
                }
            }
      }
    
      public static void beforeUpdate(List<Case> newCases, Map<Id, Case> oldMap) 
      {
            for (Case c : newCases) 
            {
                 Case oldCase = oldMap.get(c.Id);
                 if (oldCase.Priority != 'High' && c.Priority == 'High') 
                 {
                    c.IsEscalated = true;
                 }
            }
       }
    
       
       public static void afterInsert(List<Case> newCases) 
       {

            Set<Id> accountIds = new Set<Id>();
            for (Case c : newCases) 
            {
                if (c.AccountId != null) 
                {
                    accountIds.add(c.AccountId);
                }
            }

            
            Map<Id, Account> accMap = new Map<Id, Account>(
                [SELECT Id, Open_Case_Count__c FROM Account WHERE Id IN :accountIds]
            );
    
            List<Account> accountsToUpdate = new List<Account>();
    
            for (Id accId : accMap.keySet()) 
            {
                Account acc = accMap.get(accId);
                acc.Open_Case_Count__c =
        (acc.Open_Case_Count__c == null ? 0 : acc.Open_Case_Count__c) + 1;
                accountsToUpdate.add(acc);
            }
    
            
            if (!accountsToUpdate.isEmpty()) 
            {
                update accountsToUpdate;
            }
        }
    
        
        public static void afterUpdate(List<Case> newCases, Map<Id, Case> oldMap) 
        {

        List<Task> tasksToInsert = new List<Task>();

        for (Case c : newCases) 
        {
            Case oldCase = oldMap.get(c.Id);

            if (!oldCase.IsClosed && c.IsClosed) 
            {
                tasksToInsert.add(new Task(
                    Subject = 'Case Closed Follow-up',
                    WhatId = c.Id,
                    Status = 'Not Started',
                    Priority = 'Normal'
                ));
            }
        }

              
            if (!tasksToInsert.isEmpty()) 
            {
                insert tasksToInsert;
            }
        }
               
}
