class StandingsModel {
  final int rank;
  final String teamName;
  final int teamId;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final int goalsDiff;
  final int matchesPlayed;
  final int wins;
  final int draws;
  final int losses;

  StandingsModel({
    required this.rank,
    required this.teamName,
    required this.teamId,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalsDiff,
    required this.matchesPlayed,
    required this.wins,
    required this.draws,
    required this.losses,
  });

  factory StandingsModel.fromJson(Map<String, dynamic> json) {
    return StandingsModel(
      rank: json['rank'],
      teamName: json['team']['name'],
      teamId: json['team']['id'],
      points: json['points'],
      goalsFor: json['all']['goals']['for'],
      goalsAgainst: json['all']['goals']['against'],
      goalsDiff: json['goalsDiff'],
      matchesPlayed: json['all']['played'],
      wins: json['all']['win'],
      draws: json['all']['draw'],
      losses: json['all']['lose'],
    );
  }
}