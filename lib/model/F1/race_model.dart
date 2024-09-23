import 'package:intl/intl.dart';

  String formattedDateInLocalTime(DateTime date) {
    DateTime localDate = date.toLocal();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return dateFormat.format(localDate);
  }

class RacesModel {
  final List<Race> races;

  RacesModel({required this.races});

  factory RacesModel.fromJson(Map<String, dynamic> json) {
    var list = json['response'] as List;
    List<Race> racesList = list.map((i) => Race.fromJson(i)).toList();
    return RacesModel(races: racesList);
  }
}

class Race {
  final int id;
  final Competition competition;
  final Circuit circuit;
  final String season;
  final String type;
  final Laps laps;
  final FastestLap? fastestLap;
  final String distance;
  final String timezone;
  final DateTime date;
  final String dateToLocal;
  final String status;

  Race({
    required this.id,
    required this.competition,
    required this.circuit,
    required this.season,
    required this.type,
    required this.laps,
    this.fastestLap,
    required this.distance,
    required this.timezone,
    required this.date,
    required this.status,
    }) : dateToLocal = formattedDateInLocalTime(date);

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      id: json['id'],
      competition: Competition.fromJson(json['competition']),
      circuit: Circuit.fromJson(json['circuit']),
      season: json['season'].toString(),
      type: json['type'],
      laps: Laps.fromJson(json['laps']),
      fastestLap: json['fastest_lap'] != null ? FastestLap.fromJson(json['fastest_lap']) : null,
      distance: json['distance'],
      timezone: json['timezone'],
      date: DateTime.parse(json['date']),
      status: json['status'],
    );
  }
}

class Competition {
  final int id;
  final String name;
  final Location location;

  Competition({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      id: json['id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final String country;
  final String city;

  Location({
    required this.country,
    required this.city,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      country: json['country'],
      city: json['city'],
    );
  }
}

class Circuit {
  final int id;
  final String name;
  final String image;

  Circuit({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Circuit.fromJson(Map<String, dynamic> json) {
    return Circuit(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class Laps {
  final int total;

  Laps({
    required this.total,
  });

  factory Laps.fromJson(Map<String, dynamic> json) {
    return Laps(
      total: json['total'],
    );
  }
}

class FastestLap {
  final Driver driver;
  final String time;

  FastestLap({
    required this.driver,
    required this.time,
  });

  factory FastestLap.fromJson(Map<String, dynamic> json) {
    return FastestLap(
      driver: Driver.fromJson(json['driver']),
      time: json['time'] ?? 'No Time',
    );
  }
}

class Driver {
  final int id;

  Driver({required this.id});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(id: json['id'] ?? 0);
  }
}
