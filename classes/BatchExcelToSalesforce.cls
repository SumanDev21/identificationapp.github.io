global class BatchExcelToSalesforce implements Database.Batchable<sObject>, Database.Stateful {
     final String QUERY = 'SELECT Id, Name, Phone FROM Account WHERE Id = null';
     final Integer batchsize = 200;
     final String excelfilename = 'SampleExcelFile.xlsx';
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = QUERY;
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Account> accountsToInsert = new List<Account>();
        for (sObject record : scope) {
            Account account = (Account) record;
            accountsToInsert.add(account);
        }
        
        // Read the Excel file and create new Account records
        try {
            List<ContentDocumentLink> links = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :accountsToInsert];
            if (links.size() > 0) {
                ContentVersion cv = [SELECT Id, Title, VersionData FROM ContentVersion WHERE ContentDocumentId = :links[0].ContentDocumentId AND Title = :excelfilename ORDER BY CreatedDate DESC LIMIT 1];
                String excelData = cv.VersionData.toString();
                String[] excelLines = excelData.split('\n');
                for (Integer i = 1; i < excelLines.size(); i++) {
                    String[] excelFields = excelLines[i].split(',');
                    if (excelFields.size() == 2) {
                        Account account = new Account();
                        account.Name = excelFields[0];
                        account.Phone = excelFields[1];
                        accountsToInsert.add(account);
                    }
                }
            }
        } catch (Exception e) {
            System.debug('Error reading Excel file: ' + e.getMessage());
        }
        
        // Bulk insert new Account records
        if (accountsToInsert.size() > 0) {
            Database.SaveResult[] saveResults = Database.insert(accountsToInsert, false);
            for (Database.SaveResult saveResult : saveResults) {
                if (!saveResult.isSuccess()) {
                    System.debug('Error creating Account record: ' + saveResult.getErrors()[0].getMessage());
                }
            }
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        // Do any cleanup here
    }
}