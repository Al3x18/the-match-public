import 'package:flutter/material.dart';
import 'package:the_match/model/standings/standings_model.dart';

Row standingRow(StandingsModel standings, {bool isDark = false}) {
  TextStyle style = TextStyle(color: isDark ? Colors.white : Colors.black);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          standings.rank.toString(),
          style: style,
        ),
      ),
      Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Text(
          standings.teamName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      const Spacer(),
      Expanded(child: Text(standings.matchesPlayed.toString(), style: style)),
      Expanded(child: Text(standings.wins.toString(), style: style)),
      Expanded(child: Text(standings.draws.toString(), style: style)),
      Expanded(child: Text(standings.losses.toString(), style: style)),
      Flexible(
        flex: 2,
        fit: FlexFit.loose,
        child: Text("${standings.goalsFor}:${standings.goalsAgainst}", style: style),
      ),
      Expanded(
        child: Text(
          standings.points.toString(),
          style: style,
          textAlign: TextAlign.end,
        ),
      ),
    ],
  );
}