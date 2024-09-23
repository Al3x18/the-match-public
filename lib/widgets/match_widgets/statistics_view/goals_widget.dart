import 'package:flutter/material.dart';
import 'package:the_match/model/match/goal_details_model.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/utils/match_utils/fetch_goals_details.dart';

FutureBuilder<GoalDetailsModel> goalsNamesWidget(int matchId, {bool isDark = false}) {
  return FutureBuilder<GoalDetailsModel>(
    future: fetchGoalsDetails(matchId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(CUSTOM_BLUE_COLOR),
            backgroundColor: CUSTOM_BLUE_COLOR,
          ),
        );
      } else if (snapshot.hasError) {
        return Text("Error: ${snapshot.error}");
      } else if (snapshot.hasData) {
        final GoalDetailsModel goalDetails = snapshot.data!;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: _goalsNamesRow("home", goalDetails, isDark: isDark)),
            Flexible(child: _goalsNamesRow("away", goalDetails, isDark: isDark)),
          ],
        );
      } else {
        return const Text("No goal details available");
      }
    },
  );
}

Widget _goalsNamesRow(String homeOrAway, GoalDetailsModel goalDetails, {bool isDark = false}) {
  List<Widget> goalWidgets = [];

  if (homeOrAway == "home") {
    goalWidgets = goalDetails.homeGoals.map<Widget>((goal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${goal.minute}' - ${goal.player}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black),
              ),
            ],
          ),
          if (goal.assist != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "(${goal.assist})",
                  style: const TextStyle(fontSize: 12.6, color: Colors.grey),
                ),
              ],
            ),
        ],
      );
    }).toList();
  } else if (homeOrAway == "away") {
    goalWidgets = goalDetails.awayGoals.map<Widget>((goal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${goal.player} - ${goal.minute}'",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Colors.black),
              ),
            ],
          ),
          if (goal.assist != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "(${goal.assist})",
                  style: const TextStyle(fontSize: 12.6, color: Colors.grey),
                ),
              ],
            ),
        ],
      );
    }).toList();
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: goalWidgets,
    ),
  );
}
