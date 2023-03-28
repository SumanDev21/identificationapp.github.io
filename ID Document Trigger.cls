trigger IdentityTrigger on Identification_Document__c (before insert, before update) {
    for (Identification_Document__c c : Trigger.new) {
        // Get the first 6 digits of the ID number field
        String idNumber = c.ID_Number__c;
        String dobString = idNumber.substring(0, 6);
        String genderString = idNumber.substring(6, 10);
        String citizenString = idNumber.substring(10, 11);
        
        // Convert the date of birth string to a date
        Date dob = Date.newInstance(Integer.valueOf('19' + dobString.substring(0, 2)), Integer.valueOf(dobString.substring(2, 4)), Integer.valueOf(dobString.substring(4, 6)));
        System.debug('Date Dob >>>' + dob);
        // Determine the gender based on the ID number
        String gender;
        Integer genderNumber = Integer.valueOf(genderString);
        if (genderNumber >= 0000 && genderNumber <= 4999) {
            gender = 'Female';
        } else if (genderNumber >= 5000 && genderNumber <= 9999) {
            gender = 'Male';
        }
        // Determine the citizenship status based on the ID number
        Boolean isPermanentResident = citizenString.equals('0');
        
        // Populate the output fields
        c.Date_of_Birth__c = dob;
        c.Gender__c = gender;
        c.South_African_Resident__c = isPermanentResident;
    }
}
