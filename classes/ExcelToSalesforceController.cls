public class ExcelToSalesforceController {
     final String QUERY = 'SELECT Id, Name, Phone FROM Account WHERE Id = null';
     final Integer batchsize = 200;
     final String excelfilename = 'SampleExcelFile.xlsx';
    public PageReference upload() {
        PageReference pageRef = new PageReference('/apex/ExcelToSalesforce');
        try {
            // Create a new ContentVersion record for the uploaded file
            ContentVersion cv = new ContentVersion();
            cv.Title = excelfilename;
           // cv.VersionData = Blob.valueOf(EncodingUtil.base64Decode(uploadedFileBody));
            cv.PathOnClient = excelfilename;
            insert cv;

            // Create a new ContentDocumentLink record to link the file to the Account records
            List<Account> accountsToUpdate = [SELECT Id FROM Account];
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            for (Account acc : accountsToUpdate) {
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.LinkedEntityId = acc.Id;
                cdl.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
                cdl.ShareType = 'V';
                cdlList.add(cdl);
            }
            insert cdlList;

            // Run the batch job
            BatchExcelToSalesforce batchJob = new BatchExcelToSalesforce();
           // Database.executeBatch(batchJob, BatchExcelToSalesforce.batchsize);
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error uploading file: ' + e.getMessage()));
        }
        return pageRef;
    }
}