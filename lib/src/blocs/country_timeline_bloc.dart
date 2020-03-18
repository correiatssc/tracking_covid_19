import 'package:rxdart/rxdart.dart';
import 'package:tracking_covid_19/src/models/country_timeline.dart';
import 'package:tracking_covid_19/src/resources/repository.dart';

class CountryTimelineBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<CountryTimeline>();

  Observable<CountryTimeline> get countryTimeline => _moviesFetcher.stream;

  fetchCountryTimeline(String code) async {
    CountryTimeline itemModel = await _repository.fetchCountryTimeline(code);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = CountryTimelineBloc();
