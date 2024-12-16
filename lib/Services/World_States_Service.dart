import 'dart:convert';

import 'package:covid_app/Models/worldStatesmodel.dart';
import 'package:covid_app/Services/Utilities/App_Url.dart';
import 'package:http/http.dart' as http;

class WorldStatesService {
  Future<WorldStatesmodel> fetchWorldStates() async {
   // print('in fetch function ');
    final response = await http.get(Uri.parse(AppUrl.worldStatusApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print('in fetch function ');
      // print(data);
      return WorldStatesmodel.fromJson(data);
    } else {
      return throw ('Error');
    }
  }

  Future<List<dynamic> >fetchWorldList() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryListApi));
    if (response.statusCode == 200) {
       data = jsonDecode(response.body);
     
      return data;
    } else {
      return throw ('Error');
    }
  }
}
