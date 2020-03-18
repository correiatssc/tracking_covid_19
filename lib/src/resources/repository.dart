import 'package:tracking_covid_19/src/models/country_timeline.dart';
import 'package:tracking_covid_19/src/resources/the_virus_tracker_api_provider.dart';

class Repository {
  final theVirusTrackerApiProvider = new TheVirusTrackerApiProvider();

  Future<CountryTimeline> fetchCountryTimeline(String code) =>
      theVirusTrackerApiProvider.fetchCountryTimeline(code);
}
