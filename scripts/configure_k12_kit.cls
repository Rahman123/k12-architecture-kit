//set the configuration for K-12 Architecture Kit
//once K-12 has a managed package, this code should move
public static void initializeK12KitSettings() {
    hed__Hierarchy_Settings__c settings = hed.UTIL_CustomSettings_API.getSettings();
    settings.hed__Account_Processor__c = settings.hed__Household_Addresses_RecType__c;
    update settings;
}

//enables course connections (should be called by trial org flows only from cci)
//and sets the record types for Student and Faculty
public static void enableCourseConnections() {
    Schema.DescribeSObjectResult courseEnrollmentSchema = Schema.SObjectType.hed__Course_Enrollment__c;
    Map<String,Schema.RecordTypeInfo> rtInfosByDeveloperName = courseEnrollmentSchema.getRecordTypeInfosByDeveloperName();

    hed__Hierarchy_Settings__c settings = hed__Hierarchy_Settings__c.getOrgDefaults();

    settings.put('hed__Enable_Course_Connections__c', true);
    settings.put('hed__Student_RecType__c', rtInfosByDeveloperName.get('Student').getRecordTypeId());
    settings.put('hed__Faculty_RecType__c', rtInfosByDeveloperName.get('Faculty').getRecordTypeId());

    upsert settings;
    
}
