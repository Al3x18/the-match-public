class GoalDetailsModel {
  final List<GoalEvent> homeGoals;
  final List<GoalEvent> awayGoals;

  GoalDetailsModel({
    required this.homeGoals,
    required this.awayGoals,
  });

  factory GoalDetailsModel.fromJson(Map<String, dynamic> json) {
    List<GoalEvent> homeGoals = [];
    List<GoalEvent> awayGoals = [];

    for (var event in json['events']) {
      if (event['type'] == 'Goal') {
        GoalEvent goalEvent = GoalEvent.fromJson(event);
        if (event['team']['name'] == json['teams']['home']['name']) {
          homeGoals.add(goalEvent);
        } else if (event['team']['name'] == json['teams']['away']['name']) {
          awayGoals.add(goalEvent);
        }
      }
    }

    return GoalDetailsModel(
      homeGoals: homeGoals,
      awayGoals: awayGoals,
    );
  }
}

class GoalEvent {
  final int minute;
  final String player;
  final String? assist;

  GoalEvent({
    required this.minute,
    required this.player,
    this.assist,
  });

  factory GoalEvent.fromJson(Map<String, dynamic> json) {
    return GoalEvent(
      minute: json['time']['elapsed'],
      player: json['player']['name'],
      assist: json['assist']['name'],
    );
  }
}