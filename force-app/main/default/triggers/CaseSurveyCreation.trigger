trigger CaseSurveyCreation on Case (after update) 
{
     List<Case_Survey__c> surveys = new List<Case_Survey__c>();
    for(Case c : Trigger.new)
    {
        
        if(!Trigger.OldMap.get(c.Id).isClosed && c.isClosed)
        {
            surveys.add(new Case_Survey__c(
            Name='Survey'+c.Id,  
            Case__c=c.Id,
            Invitation_Date__c=System.today()
            ));
        }
    }
    if(!surveys.isEmpty())
    {
        insert surveys;
    }
}