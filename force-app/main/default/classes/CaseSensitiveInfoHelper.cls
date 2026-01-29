public without sharing class CaseSensitiveInfoHelper 
{
      public static void checkNotes (List<Case> caseList)
      {
          List<String> keywords = new List<String>
          {
             'password', 'ssn', 'aadhar', 'credit card'    
          };
          for (case c : caseList)
          {
              if (String.isBlank(c.Internal_Notes__c)) 
              {
                  continue;
              }
              String notes = c.Internal_Notes__c.toLowerCase();
              for(String word : keywords)
              {
                  if(notes.contains(word))
                  {
                      c.Contains_Sensitive_Info__c=true;
                      break;
                  }
              }
          }
     }
}