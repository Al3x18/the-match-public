import 'package:http/http.dart' as http;
import 'package:the_match/model/standings/standings_model.dart';
import 'package:the_match/utils/api_football_key.dart';
import 'package:the_match/utils/standings_utils/parse_standings.dart';

Future<List<StandingsModel>> fetchStandings({
  required String league,
  required String season,
}) async {
  final response = await http.get(
    Uri.parse(
        'https://v3.football.api-sports.io/standings?league=$league&season=$season'),
    headers: {
      'x-rapidapi-key': API_FOOTBALL_API_KEY,
      'x-rapidapi-host': 'v3.football.api-sports.io',
    },
  );

  if (response.statusCode == 200) {
    return parseStandings(response.body);
  } else {
    throw Exception('Failed to load standings');
  }
}