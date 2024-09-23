import 'package:flutter/material.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/utils/match_utils/get_card_border_color.dart';

Widget matchTime({required String dataDayMonth, required String dataHourMin, String dateDay = "", required bool isDayNameVisible, required appLogotype, bool isDark = false}) {
  return Container(
    margin: const EdgeInsets.only(left: MATCH_HORIZONTAL_PADDING),
    width: 50,
    height: MATCH_CONTAINER_HEIGHT,
    decoration: BoxDecoration(
      color: isDark ? Colors.black : MATCH_CONTAINER_BACKGROUND_COLOR,
      border: Border.all(
        width: MATCH_CONTAINER_BORDER_WIDTH,
        color: getBorderColor(appLogotype),
      ),
      borderRadius: BorderRadius.circular(MATCH_CONTAINER_RADIUS),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: dateDay.isNotEmpty && isDayNameVisible,
          child: Text(
            dateDay,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          "$dataDayMonth\n$dataHourMin",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );
}
