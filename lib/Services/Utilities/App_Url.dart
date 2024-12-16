// we use this class so when ever url get change we only have to make changes at one places 

class AppUrl {
   static const String baseUrl = 'https://disease.sh/v3/covid-19/';
// fetch word states 
// End Points 
   static const String worldStatusApi = '${baseUrl}all';
   static const String countryListApi = '${baseUrl}countries';
}
