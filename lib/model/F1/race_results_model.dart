class RaceResultsModel {
  final List<Results> results;

  RaceResultsModel({required this.results});

  factory RaceResultsModel.fromJson(Map<String, dynamic> json) {
    var list = json['response'] as List;
    List<Results> resultsList = list.map((i) => Results.fromJson(i)).toList();
    return RaceResultsModel(results: resultsList);
  }
}

class Results {
  final Driver driver;
  final Team team;
  final int position;
  final String time;
  final int laps;
  final String grid;
  final int pits;

  Results({
    required this.driver,
    required this.team,
    required this.position,
    required this.time,
    required this.laps,
    required this.grid,
    required this.pits,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      driver: Driver.fromJson(json['driver']),
      team: Team.fromJson(json['team']),
      position: json['position'] ?? 0,
      time: json['time'] ?? 'Unknown',
      laps: json['laps'] ?? 0,
      grid: json['grid'] ?? 'Unknown',
      pits: json['pits'] ?? 0,
    );
  }
}

class Driver {
  final int id;
  final String name;
  final String abbr;
  final int number;
  final String image;

  Driver({
    required this.id,
    required this.name,
    required this.abbr,
    required this.number,
    required this.image,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      abbr: json['abbr'] ?? 'Unknown',
      number: json['number'] ?? 0,
      image: json['image'] ?? 'Unknown',
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
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      logo: json['logo'] ?? 'Unknown',
    );
  }
}
