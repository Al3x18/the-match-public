import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MatchModel {
  final int fixtureId;
  final String homeTeamName;
  final String homeTeamLogo;
  final String awayTeamName;
  final String awayTeamLogo;
  final int? homeGoals;
  final int? awayGoals;
  final String status;
  final String date;
  final String dateDayMonth;
  final String dateYear;
  final String dateHourMinute;
  final String dateDay;
  final int timeElapsed;
  final String referee;
  final String city;
  final String stadium;
  final int halfTimeGoalsHome;
  final int halfTimeGoalsAway;

  MatchModel({
    required this.fixtureId,
    required this.homeTeamName,
    required this.homeTeamLogo,
    required this.awayTeamName,
    required this.awayTeamLogo,
    required this.homeGoals,
    required this.awayGoals,
    required this.status,
    required this.date,
    required this.dateDayMonth,
    required this.dateYear,
    required this.dateHourMinute,
    required this.dateDay,
    required this.timeElapsed,
    required this.referee,
    required this.city,
    required this.stadium,
    required this.halfTimeGoalsHome,
    required this.halfTimeGoalsAway,
  });

  DateTime get dateTime => DateTime.parse(date);

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    tz.initializeTimeZones();

    String dateString = json['fixture']['date'];
    DateTime parsedDate = DateTime.parse(dateString);

    final timeZone = tz.getLocation('Europe/Rome');
    final tz.TZDateTime localDate = tz.TZDateTime.from(parsedDate, timeZone);

    String dateDayMonth = DateFormat('dd/MM').format(localDate);
    String dateYear = DateFormat('yyyy').format(localDate);
    String dateHourMinute = DateFormat('HH:mm').format(localDate);
    String dateDay = DateFormat('EEE').format(localDate);

    return MatchModel(
      fixtureId: json['fixture']['id'],
      homeTeamName: json['teams']['home']['name'],
      homeTeamLogo: json['teams']['home']['logo'],
      awayTeamName: json['teams']['away']['name'],
      awayTeamLogo: json['teams']['away']['logo'],
      homeGoals: json['goals']['home'],
      awayGoals: json['goals']['away'],
      status: json['fixture']['status']['long'] ?? "no status",
      date: dateString,
      dateDayMonth: dateDayMonth,
      dateYear: dateYear,
      dateHourMinute: dateHourMinute,
      dateDay: dateDay,
      timeElapsed: json['fixture']['status']['elapsed'] ?? 0,
      referee: json['fixture']['referee'] ?? "Currently Unknown",
      city: json['fixture']['venue']['city'] ?? "Currently Unknown",
      stadium: json['fixture']['venue']['name'] ?? "Currently Unknown",
      halfTimeGoalsHome: json['score']['halftime']['home'] ?? 0,
      halfTimeGoalsAway: json['score']['halftime']['away'] ?? 0,
    );
  }
}
