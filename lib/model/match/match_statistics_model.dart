 class Team {
  final int id;
  final String name;
  final String logo;
  final List<Statistic> statistics;

  Team({
    required this.id,
    required this.name,
    required this.logo,
    required this.statistics,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var statsList = json['statistics'] as List;
    List<Statistic> statistics = statsList.map((i) => Statistic.fromJson(i)).toList();

    return Team(
      id: json['team']['id'],
      name: json['team']['name'],
      logo: json['team']['logo'],
      statistics: statistics,
    );
  }

  dynamic _getStatValue(String type) {
    return statistics.firstWhere(
      (stat) => stat.type == type,
      orElse: () => Statistic(type: type, value: "Unknown"),
    ).value;
  }

  dynamic get shotsOnGoal => _getStatValue("Shots on Goal");
  dynamic get shotsOffGoal => _getStatValue("Shots off Goal");
  dynamic get totalShots => _getStatValue("Total Shots");
  dynamic get blockedShots => _getStatValue("Blocked Shots");
  dynamic get shotsInsideBox => _getStatValue("Shots insidebox");
  dynamic get shotsOutsideBox => _getStatValue("Shots outsidebox");
  dynamic get fouls => _getStatValue("Fouls");
  dynamic get cornerKicks => _getStatValue("Corner Kicks");
  dynamic get offsides => _getStatValue("Offsides");
  dynamic get ballPossession => _getStatValue("Ball Possession");
  dynamic get yellowCards => _getStatValue("Yellow Cards");
  dynamic get redCards => _getStatValue("Red Cards");
  dynamic get goalKeeperSaves => _getStatValue("Goalkeeper Saves");
  dynamic get totalPasses => _getStatValue("Total passes");
  dynamic get passesAccurate => _getStatValue("Passes accurate");
  dynamic get passesPercentage => _getStatValue("Passes %");
  dynamic get expectedGoals => _getStatValue("expected_goals");
  dynamic get goalsPrevented => _getStatValue("goals_prevented");
}

class Statistic {
  final String type;
  final dynamic value;

  Statistic({
    required this.type,
    required this.value,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      type: json['type'],
      value: json['value'],
    );
  }
}

class MatchStatisticsModel {
  final Team teamHome;
  final Team teamAway;

  MatchStatisticsModel({
    required this.teamHome,
    required this.teamAway,
  });

  factory MatchStatisticsModel.fromJson(Map<String, dynamic> json) {
    return MatchStatisticsModel(
      teamHome: Team.fromJson(json['response'][0]),
      teamAway: Team.fromJson(json['response'][1]),
    );
  }
}