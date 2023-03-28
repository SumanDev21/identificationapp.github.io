@RestResource(urlMapping='/search')
global class searchControllerWeb {
    
    @HttpGet
    global static List<SObject> searchRecords() {
        String objectName = 'Identification_Document__c';
        String searchQuery = 'SELECT Id,Name,ID_Number__c FROM' + objectName;
  
        return Database.query(searchQuery);
    }
}

