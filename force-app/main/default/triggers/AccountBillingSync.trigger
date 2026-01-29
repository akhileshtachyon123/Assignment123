trigger AccountBillingSync on Account (after update) 
{
      Set<Id> accIds = new Set<id>();
      for(Account a : Trigger.new)
      {
          Account oldacc = Trigger.OldMap.get(a.Id);
          if(a.BillingStreet != oldacc.BillingStreet ||
             a.Billingcity != oldacc.BillingCity ||
             a.BillingState != oldacc.BillingState ||
             a.BillingPostalCode != oldacc.BillingPostalCode ||
             a.BillingCountry != oldacc.BillingCountry)
          {
              accIds.add(a.id);
          }
      }
      if(!accIds.IsEmpty())
      {
          List<opportunity> opps = [
              Select Id,AccountId from Opportunity WHERE AccountId IN:accIds AND IsClosed= false
          ];
      
      Map<Id,Account> accMap = new Map<Id,Account>(
      [Select Id, BillingStreet,
       BillingCity,
       BillingState,
       BillingPostalCode,
       BillingCountry 
       FROM Account 
       WHERE Id IN: accIds]
      );
       
          
       for(opportunity o : opps)
       {
           Account a = accMap.get(o.AccountId);
           
       }
      }
}