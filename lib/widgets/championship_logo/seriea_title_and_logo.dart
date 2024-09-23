import 'package:flutter/material.dart';
import 'package:the_match/utils/globals.dart';

Widget serieATitleAndLogo({bool isDark = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: LOGO_HORIZONTAL_PADDING),
    child: Row(
      children: [
        Image.asset(LOGO_SERIE_A_IMAGE_PATH, height: LOGO_IMAGE_HEIGHT),
        const SizedBox(width: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Lega\n",
                style: TextStyle(
                  color: isDark ? Colors.grey : Colors.black,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
              TextSpan(
                text: "Serie A",
                style: TextStyle(
                  color: isDark ? Colors.white : CUSTOM_BLUE_COLOR,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: TITLE_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}