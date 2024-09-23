import 'dart:convert';
import 'package:the_match/model/match/match_model.dart';

List<MatchModel> parseMatches(String responseBody) {
  final Map<String, dynamic> parsed = json.decode(responseBody);

  if (parsed['response'] == null || parsed['response'] is! List) {
    throw Exception("Invalid JSON structure: 'response' is null or not a list");
  }

  final List<dynamic> matchesList = parsed['response'];

  List<MatchModel> matches = matchesList.map<MatchModel>((json) => MatchModel.fromJson(json)).toList();

  matches.sort((a, b) => a.dateTime.compareTo(b.dateTime));

  return matches;
}