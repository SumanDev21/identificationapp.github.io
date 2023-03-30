public class LeadAsynchronous {
    @future
    public static void updateLeadRecords(List<Id> existingRecordsIds){
        List<Lead> existingRecords =[SELECT Id, LeadSource FROM Lead WHERE Id IN :existingRecordsIds];
        for(Lead record : existingRecords){
            record.LeadSource = 'Web';
        }
        update existingRecords;
    }
    
    
    
    @future
    public static void createLeadRecords(){
        Lead anotherLead = new Lead(LastName ='Test Lead Single',Status='Open - Not Contacted',Company = 'SFDCSumans Academy');
        insert anotherLead;
    }
}