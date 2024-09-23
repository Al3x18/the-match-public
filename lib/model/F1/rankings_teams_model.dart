class RankingsTeamsModel {
  final List<Rankings> rankings;

  RankingsTeamsModel({
    required this.rankings,
  });

  factory RankingsTeamsModel.fromJson(Map<String, dynamic> json) {
    var list = json['response'] as List;
    List<Rankings> rankingsList = list.map((i) => Rankings.fromJson(i)).toList();
    return RankingsTeamsModel(rankings: rankingsList);
  }
}

class Rankings {
  final int position;
  final Team team;
  final int points;

  Rankings({
    required this.position,
    required this.team,
    required this.points,
  });

  factory Rankings.fromJson(Map<String, dynamic> json) {
    return Rankings(
      position: json['position'],
      team: Team.fromJson(json['team']),
      points: json['points'],
    );
  }
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
