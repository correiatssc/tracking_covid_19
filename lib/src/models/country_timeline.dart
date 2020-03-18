import 'data_points.dart';

class CountryTimeline {
  List<DataPoint> timelineDataPoints;

  CountryTimeline.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> dataPoints = json['timelineitems'][0];
    timelineDataPoints = dataPoints.entries
        .map((e) {
          if (e.key != 'stat') {
            return new DataPoint(e.key, e.value as Map<String, dynamic>);
          } else {
            return null;
          }
        })
        .where((e) => e != null)
        .toList();
  }
}
