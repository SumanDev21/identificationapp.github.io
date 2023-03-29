#Salesforce Developer Assessment

I have created a basic web page hosted from this repository (identificationapp.github.io) and this can be found on the index.html file 

The index.html file contains the structure of the input search bar for the user to input their 13 digit ID number

The logic for validating the users ID is in the index.html file as well as for checking to see if a users Date of Birth corresponds with a public holiday

The index.html file also houses the logic for separating the ID number into respective key elements such as DOB , Gender and whether or not the user is a South African citizen or permanenet resident. 

I have attempted to make a web page api call to the searchControllerWeb.cls class in my Developer org to search for the existing IDs in the salesforce database but I have failed to successfully make this query possible on the website
I have created a custom object (Identification_Document__c) in the Sandbox which on creation allows the user to strictly input a valid ID number and when the record is created a custom apex trigger(ID Document Trigger.cls) is fired to extract the relevant information from the ID number such as DOB , Gender and whether or not the user is a South African citizen or permanenet resident as this is automatically populated on the custom fields created on the Identification_Document__c object



