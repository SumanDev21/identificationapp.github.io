public class LeadBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }
    
    public void execute(Database.BatchableContext BC, List<Lead> scope){
        for(Lead leadrecord : scope){
            leadrecord.LeadSource = 'Web';
           }
        update scope;
    }
    
    public void finish(Database.BatchableContext BC){
        System.debug('Batch Finished');
    }
}