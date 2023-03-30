@RestResource(urlMapping = '/api/webhooks/shortcutchanges')
global with sharing class ShortcutWebhook {
    @HttpPost
    
    global static void handleChangesShortcut(){
        RestRequest req = RestContext.request;
        String requestBody = req.requestBody.toString();
        
        // Parse the request body as JSON
        Map<String, Object> requestData = (Map<String, Object>) JSON.deserializeUntyped(requestBody);
        
        // Extract the fields you're interested in
        String field1 = (String) requestData.get('name');
        // ...
        
        // Map the extracted fields to a custom object
        Case caseobject = new Case();
        caseobject.Subject = field1;
        // ...
        
        // Insert the custom object into the database
        insert caseobject;
        
        // Return a response
    }
}