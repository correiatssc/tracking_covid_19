import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tracking_covid_19/src/models/country_timeline.dart';

class TheVirusTrackerApiProvider {
  Future<CountryTimeline> fetchCountryTimeline(String code) async {
    try {
      final response = await http
          .get("https://thevirustracker.com/free-api?countryTimeline=$code");
      print(response.body.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        var data = json.decode(response.body);
        return CountryTimeline.fromJson(data);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to load post');
    }
  }
}
