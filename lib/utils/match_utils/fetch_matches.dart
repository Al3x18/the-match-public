import 'package:the_match/model/match/match_model.dart';
import 'package:http/http.dart' as http;
import 'package:the_match/utils/api_football_key.dart';
import 'package:the_match/utils/match_utils/parse_match.dart';

Future<List<MatchModel>> fetchMatches({
  required String league,
  required String season,
  required String round,
}) async {
  final response = await http.get(
    Uri.parse(
        'https://v3.football.api-sports.io/fixtures?league=$league&season=$season&round=Regular%20Season%20-%20$round&timezone=Europe%2FRome'),
    headers: {
      'x-rapidapi-key': API_FOOTBALL_API_KEY,
      'x-rapidapi-host': 'v3.football.api-sports.io',
    },
  );

  if (response.statusCode == 200) {
    return parseMatches(response.body);
  } else {
    throw Exception('Failed to load matches');
  }
}
