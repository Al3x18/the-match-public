import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:the_match/model/match/match_statistics_model.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/utils/match_utils/fetch_stats.dart';
import 'package:the_match/widgets/match_widgets/statistics_view/goals_widget.dart';

FutureBuilder<MatchStatisticsModel> matchStatsWidget({required int matchId, required String goalHome, required String goalAway, bool isDark = false}) {
  return FutureBuilder<MatchStatisticsModel>(
    future: fetchMatchStats(matchId),
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
        final MatchStatisticsModel matchStats = snapshot.data!;
        final String teamHomeBallPossession = matchStats.teamHome.ballPossession;
        final int teamHomeBallPossessionInt = int.parse(teamHomeBallPossession.split("%")[0]);

        final String teamHomePassingAccuracy = matchStats.teamHome.passesPercentage;
        final int teamHomePassingAccuracyInt = int.parse(teamHomePassingAccuracy.split("%")[0]);

        final String teamAwayPassingAccuracy = matchStats.teamAway.passesPercentage;
        final int teamAwayPassingAccuracyInt = int.parse(teamAwayPassingAccuracy.split("%")[0]);

        return Column(
          children: [
            teamsVS(matchStats.teamHome.name, matchStats.teamAway.name, matchStats.teamHome.logo, matchStats.teamAway.logo),
            goalsRow(goalHome == "null" ? "0" : goalHome, goalAway == "null" ? "0" : goalAway, isDark: isDark),
            goalsNamesWidget(matchId, isDark: isDark),
            const Divider(indent: 16, endIndent: 16, thickness: 0.4, color: CUSTOM_BLUE_COLOR),
            statRow(matchStats.teamHome.expectedGoals, "xG (expected goals)", matchStats.teamAway.expectedGoals, isDark: isDark),
            statRow(matchStats.teamHome.shotsOnGoal, "Shots On Goal", matchStats.teamAway.shotsOnGoal, isDark: isDark),
            statRow(matchStats.teamHome.shotsOffGoal, "Shots Off Goal", matchStats.teamAway.shotsOffGoal, isDark: isDark),
            statRow(matchStats.teamHome.totalShots, "Total Shots", matchStats.teamAway.totalShots, isDark: isDark),
            statRow(matchStats.teamHome.shotsInsideBox, "Shots Inside Box", matchStats.teamAway.shotsInsideBox, isDark: isDark),
            statRow(matchStats.teamHome.shotsOutsideBox, "Shots Outside Box", matchStats.teamAway.shotsOutsideBox, isDark: isDark),
            statRow(matchStats.teamHome.fouls, "Fouls", matchStats.teamAway.fouls, isDark: isDark),
            statRow(matchStats.teamHome.cornerKicks, "Corner Kicks", matchStats.teamAway.cornerKicks, isDark: isDark),
            statRow(matchStats.teamHome.offsides, "Offsides", matchStats.teamAway.offsides, isDark: isDark),
            statRow(matchStats.teamHome.yellowCards, "Yellow Cards", matchStats.teamAway.yellowCards, isDark: isDark),
            statRow(matchStats.teamHome.redCards == "Unknown" ? "0" : matchStats.teamAway.redCards, "Red Cards", matchStats.teamAway.redCards == "Unknown" ? "0" : matchStats.teamAway.redCards, isDark: isDark),
            statRow(matchStats.teamHome.goalKeeperSaves, "Goalkeeper Saves", matchStats.teamAway.goalKeeperSaves, isDark: isDark),
            statRow(matchStats.teamHome.totalPasses, "Total Passes", matchStats.teamAway.totalPasses, isDark: isDark),
            const SizedBox(height: 30),
            ballPossessionPercentIndicator(teamHomeBallPossessionInt, matchStats, isDark: isDark),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                passingAccuracyPercentIndicator(teamName: matchStats.teamHome.name, percent: teamHomePassingAccuracyInt, type: "home", isDark: isDark),
                passingAccuracyPercentIndicator(teamName: matchStats.teamAway.name, percent: teamAwayPassingAccuracyInt, type: "away", isDark: isDark),
              ],
            ),
            const SizedBox(height: 52),
          ],
        );
      } else {
        return const Text("No match statistics available");
      }
    },
  );
}

Widget teamsVS(String teamHomeName, String teamAwayName, String teamHomeLogo, String teamAwayLogo) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.network(teamHomeLogo),
            ),
            const Text(
              "VS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: Image.network(teamAwayLogo),
            ),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        height: 26.5,
        decoration: const BoxDecoration(color: CUSTOM_BLUE_COLOR),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                teamHomeName,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
              ),
              Text(
                teamAwayName,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget goalsRow(String teamHomeValue, String teamAwayValue, {bool isDark = false}) {
  TextStyle style = TextStyle(fontWeight: FontWeight.w700, fontSize: 18.5, color: isDark ? Colors.white : Colors.black);
  return Padding(
    padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(teamHomeValue, style: style),
        Text("GOALS", style: style),
        Text(teamAwayValue, style: style),
      ],
    ),
  );
}

Widget statRow(dynamic teamHomeValue, String statsType, dynamic teamAwayValue, {bool isDark = false}) {
  TextStyle style = TextStyle(color: isDark ? Colors.white : Colors.black);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8.2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(teamHomeValue.toString() == "null" ? "0" : teamHomeValue.toString(), style: style),
        Text(statsType, style: style),
        Text(teamAwayValue.toString() == "null" ? "0" : teamAwayValue.toString(), style: style),
      ],
    ),
  );
}

CircularPercentIndicator ballPossessionPercentIndicator(int teamHomeBallPossessionInt, var matchStats, {bool isDark = false}) {
  return CircularPercentIndicator(
    animation: true,
    animationDuration: CIRCULAR_PROGRESS_INDICATOR_ANIMATION_DURATION,
    radius: CIRCULAR_PROGRESS_INDICATOR_RADIUS,
    lineWidth: CIRCULAR_PROGRESS_INDICATOR_LINE_WIDTH,
    percent: teamHomeBallPossessionInt / 100,
    center: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT,
          textAlign: TextAlign.center,
          style: isDark ? CIRCULAR_PROGRESS_INDICATOR_CENTER_DARK_TEXT_STYLE_TITLE : CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_TITLE,
        ),
        const SizedBox(height: 14),
        Text(matchStats!.teamHome.name, style: CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_SUBTITLE_HOME),
        Text(matchStats!.teamHome.ballPossession, style: CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_SUBTITLE_HOME),
        const SizedBox(height: 6),
        Text(matchStats!.teamAway.name, style: CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_SUBTITLE_AWAY),
        Text(matchStats!.teamAway.ballPossession, style: CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_SUBTITLE_AWAY),
      ],
    ),
    circularStrokeCap: CircularStrokeCap.round,
    backgroundColor: AWAY_TEAM_COLOR,
    progressColor: HOME_TEAM_COLOR,
  );
}

CircularPercentIndicator passingAccuracyPercentIndicator({required String teamName, required int percent, String type = "home", bool isDark = false}) {
  return CircularPercentIndicator(
    radius: CIRCULAR_PROGRESS_INDICATOR_PA_RADIUS,
    percent: percent / 100,
    lineWidth: CIRCULAR_PROGRESS_INDICATOR_PA_LINE_WIDTH,
    progressColor: type == "home" ? CUSTOM_BLUE_COLOR : Colors.black,
    backgroundColor: Colors.grey.shade300,
    circularStrokeCap: CircularStrokeCap.round,
    center: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("PA", style: isDark ? CIRCULAR_PROGRESS_INDICATOR_PA_CENTER_DARK_TEXT_STYLE : CIRCULAR_PROGRESS_INDICATOR_PA_CENTER_TEXT_STYLE),
        Text("$percent %", style: isDark ? CIRCULAR_PROGRESS_INDICATOR_PA_CENTER_DARK_TEXT_STYLE : CIRCULAR_PROGRESS_INDICATOR_PA_CENTER_TEXT_STYLE),
      ],
    ),
    footer: Padding(
      padding: const EdgeInsets.only(top: 8.5),
      child: Text(
        "$teamName$CIRCULAR_PROGRESS_INDICATOR_PA_FOOTER_TEXT",
        style: CIRCULAR_PROGRESS_INDICATOR_PA_FOOTER_TEXT_STYLE,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
