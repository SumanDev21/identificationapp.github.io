trigger LeadTrigger on Lead (before insert,before update) {
    //System.debug('Lead Trigger Called');
    for(Lead leadRecord : Trigger.new){
        if(String.isBlank(leadRecord.LeadSource)){
          leadRecord.LeadSource = 'Other';  
        }
        
        if(String.isBlank(leadRecord.Industry)){
            leadRecord.addError('Industry field cannot be blank');
        }
        
    }
}