import 'package:flutter/material.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/utils/match_utils/get_card_border_color.dart';

Widget matchCard({
  required teamHomeLogoPath,
  required teamAwayLogoPath,
  required String homeGoals,
  required String awayGoals,
  required String status,
  required int timeElapsed,
  required LOGOTYPE appLogotype,
  bool isDark = false,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: MATCH_HORIZONTAL_PADDING, vertical: MATCH_VERTICAL_PADDING),
    height: MATCH_CONTAINER_HEIGHT,
    width: MATCH_CONTAINER_WIDTH,
    decoration: BoxDecoration(
      color: isDark ? Colors.black : MATCH_CONTAINER_BACKGROUND_COLOR,
      border: Border.all(
        width: MATCH_CONTAINER_BORDER_WIDTH,
        color: getBorderColor(appLogotype),
      ),
      borderRadius: BorderRadius.circular(MATCH_CONTAINER_RADIUS),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _teamLogo(imagePath: teamHomeLogoPath, team: TEAM.HOME),
        _resultAndTime(homeGoals: homeGoals, awayGoals: awayGoals, status: status, timeElapsed: timeElapsed, isDark: isDark),
        _teamLogo(imagePath: teamAwayLogoPath, team: TEAM.AWAY),
      ],
    ),
  );
}

Column _resultAndTime({
  required String homeGoals,
  required String awayGoals,
  required String status,
  required int timeElapsed,
  bool isDark = false,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "${homeGoals == "null" ? "0" : homeGoals} - ${awayGoals == "null" ? "0" : awayGoals}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: isDark ? Colors.white : Colors.black),
      ),
      Text(
        status == "Not Started"
            ? "Not Started"
            : status == "Match Finished"
                ? "Match Finished"
                : status == "Time to be defined"
                    ? "TBD"
                    : "${timeElapsed.toString()} min",
        style: TextStyle(
          color: status == "Match Finished"
              ? Colors.grey
              : status == "Time to be defined"
                  ? Colors.grey
                  : status == "Not Started"
                      ? Colors.grey
                      : Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Container _teamLogo({required String imagePath, required TEAM team}) {
  return Container(
    width: TEAM_LOGO_CONTAINER_WIDTH,
    decoration: BoxDecoration(
      color: TEAM_LOGO_BACKGROUND_COLOR,
      borderRadius: BorderRadius.only(
        topLeft: team == TEAM.HOME ? const Radius.circular(TEAM_LOGO_RADIUS) : Radius.zero,
        bottomLeft: team == TEAM.HOME ? const Radius.circular(TEAM_LOGO_RADIUS) : Radius.zero,
        topRight: team == TEAM.AWAY ? const Radius.circular(TEAM_LOGO_RADIUS) : Radius.zero,
        bottomRight: team == TEAM.AWAY ? const Radius.circular(TEAM_LOGO_RADIUS) : Radius.zero,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(TEAM_LOGO_IMAGE_PADDING),
      child: Image.network(
        imagePath,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    ),
  );
}
