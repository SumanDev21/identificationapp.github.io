public class LeadSchedulable implements Schedulable {

    
    public void execute(SchedulableContext sc){
        // write actual functions of code here
     List<Lead> existingRecords = [SELECT Id, LeadSource FROM Lead];
        //write async code here 
        for(Lead record : existingRecords){
            record.LeadSource = 'Web';
        }
        update existingRecords;
    }
}