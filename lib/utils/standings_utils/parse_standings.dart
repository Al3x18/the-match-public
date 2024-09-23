import 'dart:convert';

import 'package:the_match/model/standings/standings_model.dart';

List<StandingsModel> parseStandings(String responseBody) {
  final Map<String, dynamic> parsed = json.decode(responseBody);

  if (parsed['response'] == null || parsed['response'] is! List) {
    throw Exception("Invalid JSON structure: 'response' is null or not a list");
  }

  final List<dynamic> standingsList = parsed['response'][0]['league']['standings'][0].cast<Map<String, dynamic>>();

  List<StandingsModel> standings = standingsList.map<StandingsModel>((json) => StandingsModel.fromJson(json)).toList();

  return standings;
}