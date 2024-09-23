import 'dart:convert';

import 'package:the_match/model/match/goal_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:the_match/utils/api_football_key.dart';

Future<GoalDetailsModel> fetchGoalsDetails(int matchId) async {
  final String url = 'https://v3.football.api-sports.io/fixtures?id=$matchId';

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'x-rapidapi-key': API_FOOTBALL_API_KEY,
      'x-rapidapi-host': 'v3.football.api-sports.io',
    },
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return GoalDetailsModel.fromJson(json['response'][0]);
  } else {
    throw Exception('Failed to load fixture details');
  }
}
