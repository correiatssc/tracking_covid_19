import 'package:intl/intl.dart';

class DataPoint {
  DataPoint(String date, Map<String, dynamic> values) {
    this.date = DateFormat("M/d/yyyy").parse(date);
    this.newDailyCases = values['new_daily_cases'];
    this.newDailyDeaths = values['new_daily_deaths'];
    this.totalCases = values['total_cases'];
    this.totalRecoveries = values['total_recoveries'];
    this.totalDeaths = values['total_deaths'];
  }

  DateTime date;
  int newDailyCases;
  int newDailyDeaths;
  int totalCases;
  int totalRecoveries;
  int totalDeaths;
}
