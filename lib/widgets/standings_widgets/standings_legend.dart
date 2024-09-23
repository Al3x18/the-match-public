import 'package:flutter/material.dart';
import 'package:the_match/utils/globals.dart';

Widget buildStandingsLegend({bool isDark = false}) {
  TextStyle style = TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black);
  return Container(
    padding: const EdgeInsets.symmetric(vertical: STANDINGS_VERTICAL_PADDING, horizontal: STANDINGS_HORIZONTAL_PADDING),
    color: isDark ? Colors.black : Colors.grey[300],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text("#", style: style)),
        Flexible(flex: 3, fit: FlexFit.tight, child: Text("Team", style: style)),
        const Spacer(),
        Expanded(child: Text("P", style: style)),
        Expanded(child: Text("W", style: style)),
        Expanded(child: Text("N", style: style)),
        Expanded(child: Text("L", style: style)),
        Flexible(flex: 2, child: Text("+/-", style: style)),
        Expanded(child: Text("Pts", style: style, textAlign: TextAlign.end)),
      ],
    ),
  );
}
