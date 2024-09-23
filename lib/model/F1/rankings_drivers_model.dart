class DriverStandingsModel {
  final List<DriverRanking> rankings;

  DriverStandingsModel({
    required this.rankings,
  });

  factory DriverStandingsModel.fromJson(Map<String, dynamic> json) {
    var list = json['response'] as List;
    List<DriverRanking> rankingsList = list.map((i) => DriverRanking.fromJson(i)).toList();
    return DriverStandingsModel(rankings: rankingsList);
  }
}

class DriverRanking {
  final int position;
  final Driver driver;
  final Team team;
  final int points;
  final int wins;
  final int? behind;
  final int season;

  DriverRanking({
    required this.position,
    required this.driver,
    required this.team,
    required this.points,
    required this.wins,
    this.behind,
    required this.season,
  });

  factory DriverRanking.fromJson(Map<String, dynamic> json) {
    return DriverRanking(
      position: json['position'] ?? 0,
      driver: Driver.fromJson(json['driver']),
      team: Team.fromJson(json['team']),
      points: json['points'] ?? 0,
      wins: json['wins'] ?? 0,
      behind: json['behind'] ?? 0,
      season: json['season'] ?? 0,
    );
  }
}

class Driver {
  final int id;
  final String name;
  final String? abbr;
  final int number;
  final String image;

  Driver({
    required this.id,
    required this.name,
    this.abbr,
    required this.number,
    required this.image,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      abbr: json['abbr'] ?? 'No abbr',
      number: json['number'] ?? 0,
      image: json['image'] ?? 'No image',
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