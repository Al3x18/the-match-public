import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_match/model/F1/race_model.dart';
import 'package:the_match/utils/api_football_key.dart';

Future<RacesModel> fetchRaces(String seasonYear) async {
  final response = await http.get(
    Uri.parse('https://v1.formula-1.api-sports.io/races?type=race&season=$seasonYear'),
    headers: {
      'X-RapidAPI-Key': API_FOOTBALL_API_KEY,
      'X-RapidAPI-Host': 'v3.football.api-sports.io',
    },
  );

  if (response.statusCode == 200) {
    //print("response: ${response.body}");
    return RacesModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load races');
  }
}
