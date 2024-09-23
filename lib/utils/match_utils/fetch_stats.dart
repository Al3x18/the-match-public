import 'dart:convert';

import 'package:the_match/model/match/match_statistics_model.dart';
import 'package:http/http.dart' as http;
import 'package:the_match/utils/api_football_key.dart';

Future<MatchStatisticsModel> fetchMatchStats(int matchId) async {
  final response = await http.get(
    Uri.parse('https://v3.football.api-sports.io/fixtures/statistics?fixture=$matchId'),
    headers: {
      'x-rapidapi-key': API_FOOTBALL_API_KEY,
      'x-rapidapi-host': 'v3.football.api-sports.io',
    },
  );

  if (response.statusCode == 200) {
    return MatchStatisticsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load match statistics');
  }
}
