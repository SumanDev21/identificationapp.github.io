public class LeadQueueable implements Queueable{
 
    
    
    public void execute(QueueableContext context){
        List<Lead> existingRecords = [SELECT Id, LeadSource FROM Lead];
        //write async code here 
        for(Lead record : existingRecords){
            record.LeadSource = 'Web';
        }
        update existingRecords;
    }
}