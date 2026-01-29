trigger CaseRouting on Case (before insert) 
{
     Map<String,Case_Routing_Rule__mdt> rules = Case_Routing_Rule__mdt.getAll();
     for(Case c : Trigger.new)
     {
         String key = c.Product__c + '-' + c.Region__c;
         if(rules.containsKey(key))
         {
             c.OwnerId=rules.get(key).Queue__c;
         }
     }
}