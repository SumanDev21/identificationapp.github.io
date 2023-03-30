@RestResource(urlMapping='/HolidayService/*')
global with sharing class HolidayService {
    
    private static final String API_KEY = '24c5e86734eb44dc4a962826324a5546e74dc42f';
    private static final String ENDPOINT_URL = 'https://calendariﬁc.com/api/v2/holidays?api_key=' + API_KEY + '&country=ZA&year=';
    
    @HttpGet
    global static List<Holiday> getHolidays() {
        String year = RestContext.request.params.get('year');
        String endpointUrl = ENDPOINT_URL + year;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Holiday> holidays = new List<Holiday>();
        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> holidayList = (List<Object>)result.get('response');
            for (Object holidayObj : holidayList) {
                Map<String, Object> holidayMap = (Map<String, Object>)holidayObj;
                holidays.add(new Holiday((String)holidayMap.get('name'), (String)holidayMap.get('holiday_date')));
            }
        }
        return holidays;
    }
    
    global class Holiday {
        public String name { get; set; }
        public String holidayDate { get; set; }
        public Holiday(String name, String holidayDate) {
            this.name = name;
            this.holidayDate = holidayDate;
        }
    }
}