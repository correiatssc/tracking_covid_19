import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tracking_covid_19/src/blocs/country_timeline_bloc.dart';
import 'package:tracking_covid_19/src/models/country_code.dart';
import 'package:tracking_covid_19/src/models/country_timeline.dart';
import 'package:tracking_covid_19/src/models/data_points.dart';
import 'package:tracking_covid_19/src/ui/search_country.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        SearchCountry(),
      ], title: Text('Tracking COVID-19'), leading: Icon(Icons.track_changes)),
      body: StreamBuilder(
        stream: bloc.countryTimeline,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            CountryTimeline countryTimeline = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: TimelineChart(
                      id: 'Total Cases',
                      measureFn: (DataPoint datapoint) => datapoint.totalCases,
                      countryTimeline: countryTimeline,
                      color: charts.MaterialPalette.blue.shadeDefault),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: TimelineChart(
                      id: 'Total Recovery',
                      measureFn: (DataPoint datapoint) =>
                          datapoint.totalRecoveries,
                      countryTimeline: countryTimeline,
                      color: charts.MaterialPalette.green.shadeDefault),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: TimelineChart(
                      id: 'Total Deaths',
                      measureFn: (DataPoint datapoint) => datapoint.totalDeaths,
                      countryTimeline: countryTimeline,
                      color: charts.MaterialPalette.red.shadeDefault),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class TimelineChart extends StatelessWidget {
  const TimelineChart({
    Key key,
    @required this.id,
    @required this.measureFn,
    @required this.countryTimeline,
    @required this.color,
  }) : super(key: key);

  final String id;
  final num Function(DataPoint datapoint) measureFn;
  final CountryTimeline countryTimeline;
  final charts.Color color;

  @override
  Widget build(BuildContext context) {
    var totalCasesSerie = charts.Series<DataPoint, DateTime>(
        id: id,
        data: countryTimeline.timelineDataPoints,
        colorFn: (d, i) => color,
        domainFn: getDomain,
        measureFn: getMeasure);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: new charts.TimeSeriesChart(
        [totalCasesSerie],
        animate: true,
        // Set the default renderer to a bar renderer.
        // This can also be one of the custom renderers of the time series chart.
        defaultRenderer: new charts.BarRendererConfig<DateTime>(),
        // It is recommended that default interactions be turned off if using bar
        // renderer, because the line point highlighter is the default for time
        // series chart.
        defaultInteractions: true,
        // If default interactions were removed, optionally add select nearest
        // and the domain highlighter that are typical for bar charts.
        behaviors: [
          new charts.ChartTitle(id),
          new charts.SelectNearest(),
          new charts.DomainHighlighter(),
          new charts.PanBehavior()
        ],
      ),
    );
  }

  num getMeasure(DataPoint datapoint, _) {
    return measureFn(datapoint);
  }

  DateTime getDomain(DataPoint datapoint, _) {
    return datapoint.date;
  }
}
