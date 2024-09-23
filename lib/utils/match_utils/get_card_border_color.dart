import 'dart:ui';

import 'package:the_match/utils/globals.dart';

Color getBorderColor(LOGOTYPE appLogotype) {
  if (appLogotype == LOGOTYPE.serieA) {
    return CUSTOM_BLUE_COLOR;
  } else if (appLogotype == LOGOTYPE.premierLeague) {
    return PREMIER_LEAGUE_COLOR;
  } else if (appLogotype == LOGOTYPE.laLiga) {
    return LA_LIGA_COLOR;
  } else if (appLogotype == LOGOTYPE.ligue1) {
    return LIGUE_1_COLOR;
  } else if (appLogotype == LOGOTYPE.formula1) {
    return F1_COLOR;
  } else if (appLogotype == LOGOTYPE.bundesliga) {
    return BUNDESLIGA_COLOR;
  } else {
    return CUSTOM_BLUE_COLOR;
  }
}