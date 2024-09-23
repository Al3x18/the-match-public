// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';

enum TEAM { HOME, AWAY }

enum SEGMENTS { light, system, dark }

enum LOGOTYPE { serieA, premierLeague, laLiga, bundesliga, ligue1, formula1 }

const Color CUSTOM_BLUE_COLOR = Color.fromARGB(255, 36, 69, 255);

const Color SCAFFOLD_AND_APP_BAR_BACKGROUND_COLOR = Color.fromARGB(255, 255, 245, 245);
const Color SCAFFOLD_AND_APP_BAR_BACKGROUND_COLOR_DARK = Color.fromARGB(255, 31, 31, 31);

// MARK: Main Title and Logo
const double TITLE_FONT_SIZE = 46.0;
const FontWeight TITLE_FONT_WEIGHT = FontWeight.w800;
const double LOGO_IMAGE_HEIGHT = 90.5;
const double LOGO_HORIZONTAL_PADDING = 6.6;
const String LOGO_SERIE_A_IMAGE_PATH = "assets/images/lega-serie-a-hd-logo-2024-2025.jpg";
const String LOGO_PREMIER_LEAGUE_IMAGE_PATH = "assets/images/premier_league_logo.png";
const String LOGO_LA_LIGA_IMAGE_PATH = "assets/images/la_liga_logo.png";
const String LOGO_LIGUE_1_IMAGE_PATH = "assets/images/ligue1_logo.png";
const String LOGO_PREMIER_LEAGUE_DARK_IMAGE_PATH = "assets/images/premier_league_logo_dark.png";
const String LOGO_LA_LIGA_DARK_IMAGE_PATH = "assets/images/la_liga_logo_dark.png";
const String LOGO_LIGUE_1_DARK_IMAGE_PATH = "assets/images/ligue1_logo_dark.png";
const String LOGO_BUNDES_DARK_IMAGE_PATH = "assets/images/bundes_logo_dark.png";
const String LOGO_BUNDES_IMAGE_PATH = "assets/images/bundes_logo.png";
const String F1_LOGO_IMAGE_PATH = "assets/images/f1_logo.png";
const String F1_LOGO_DARK_IMAGE_PATH = "assets/images/f1_logo_dark.png";
const Color PREMIER_LEAGUE_COLOR = Color(0xFF3D195B);
const Color LA_LIGA_COLOR = Color(0xFFFF4B44);
const Color LIGUE_1_COLOR = Color(0xFF091C3E);
const Color SERIE_A_COLOR = Color(0xFF1A1659);
const Color BUNDESLIGA_COLOR = Colors.red;
const Color F1_COLOR = Colors.red;

// MARK: Team Logo
Color TEAM_LOGO_BACKGROUND_COLOR = const Color.fromARGB(0, 255, 255, 255);
const double TEAM_LOGO_RADIUS = 10.0;
const double TEAM_LOGO_CONTAINER_WIDTH = 82.0;
const double TEAM_LOGO_IMAGE_PADDING = 8.0;

// MARK: Tab Bar
const double TAB_BAR_SPLASH_RADIUS = 8.0;

// MARK: Match Container
const double MATCH_CONTAINER_RADIUS = 10.0;
const double MATCH_HORIZONTAL_PADDING = 4.6;
const double MATCH_VERTICAL_PADDING = 3.4;
const double MATCH_CONTAINER_HEIGHT = 72.0;
const double MATCH_CONTAINER_WIDTH = double.infinity;
const double MATCH_CONTAINER_BORDER_WIDTH = 0.6;
const Color MATCH_CONTAINER_BACKGROUND_COLOR = Colors.white;

// MARK: Dev Name
const double DEV_NAME_FONT_SIZE = 12.0;
const Color DEV_NAME_FONT_COLOR = Colors.grey;

// MARK: Standings
const double STANDINGS_VERTICAL_PADDING = 8.0;
const double STANDINGS_HORIZONTAL_PADDING = 15.0;
const double STANDINGS_LAST_ITEM_PADDING_BOTTOM = 34.0;
const double STANDINGS_FIRST_ITEM_PADDING_TOP = 12.0;
const double STANDINGS_DIVIDER_THICKNESS = 0.5;

// MARK: Set Season Year
const String SET_MIN_SEASON_YEAR_FOOTBALL = "2010";
const String SET_MIN_SEASON_YEAR_F1 = "2012";

//MARK: Save Season Year Button
const double HEIGHT_OF_SAVE_BUTTON = 36.0;
const double WIDTH_OF_SAVE_BUTTON = 202.5;
const double SAVE_BUTTON_ELEVATION = 4.0;
const double SAVE_BUTTON_RADIUS = 12.0;
const double SAVE_BUTTON_BORDER_WIDTH = 0.36;
Color SAVE_BUTTON_BACKGROUND_COLOR = Colors.grey.shade300;
const Color SAVE_BUTTON_FOREGROUND_COLOR = Colors.black;
const String SAVE_BUTTON_TEXT = "\u2714 Set Season Year";

//MARK: - Settings
const String LIST_TILE_APP_VERSION_IMAGE_ASSET_PATH = "assets/images/black_i_img.jpg";
const String DARK_LIST_TILE_APP_VERSION_IMAGE_ASSET_PATH = "assets/images/white_i_img.jpg";
const double LIST_TILE_IMAGE_ASSET_WIDTH_AND_HEIGHT = 30.0;
const double LIST_TILE_IMAGE_ASSET_RADIUS = 7.0;
const double LIST_TILE_FONT_SIZE = 15.4;
const String LIST_TILE_SEND_MAIL_IMAGE_PATH = "assets/images/black_m_img.png";
const String DARK_LIST_TILE_SEND_MAIL_IMAGE_PATH = "assets/images/white_m_img.png";
const double ARROW_ICON_SIZE = 16.0;
const String DEV_TEAM_EMAIL = "depasquale.alex@gmail.com";
const String GITHUB_URL = "https://github.com/Al3x18";
const SUBTITLE_TEXT_FONT_SIZE = 12.85;

//MARK: - Circular Progress Indicator Ball Possession
const int CIRCULAR_PROGRESS_INDICATOR_ANIMATION_DURATION = 1500;
const double CIRCULAR_PROGRESS_INDICATOR_RADIUS = 110.0;
const double CIRCULAR_PROGRESS_INDICATOR_LINE_WIDTH = 10.0;
const String CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT = "Ball\nPossession";
const TextStyle CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_TITLE = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5);
const TextStyle CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_SUBTITLE_HOME = TextStyle(fontSize: 12.5, color: HOME_TEAM_COLOR, fontWeight: FontWeight.w500);
TextStyle CIRCULAR_PROGRESS_INDICATOR_CENTER_TEXT_STYLE_SUBTITLE_AWAY = TextStyle(fontSize: 12.5, color: AWAY_TEAM_COLOR, fontWeight: FontWeight.w500);
const TextStyle CIRCULAR_PROGRESS_INDICATOR_CENTER_DARK_TEXT_STYLE_TITLE = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5, color: Colors.white);
Color AWAY_TEAM_COLOR = Colors.grey.shade500;
const Color HOME_TEAM_COLOR = CUSTOM_BLUE_COLOR;

//MARK: - Circular Progress Indicator Passing Accuracy
const double CIRCULAR_PROGRESS_INDICATOR_PA_RADIUS = 46.5;
const double CIRCULAR_PROGRESS_INDICATOR_PA_LINE_WIDTH = 5.5;
const Color CIRCULAR_PROGRESS_INDICATOR_PA_PROGRESS_COLOR = CUSTOM_BLUE_COLOR;
Color CIRCULAR_PROGRESS_INDICATOR_PA_BACKGROUND_COLOR = Colors.grey.shade300;
const String CIRCULAR_PROGRESS_INDICATOR_PA_FOOTER_TEXT = "\nPassing Accuracy";
const TextStyle CIRCULAR_PROGRESS_INDICATOR_PA_CENTER_TEXT_STYLE = TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16);
const TextStyle CIRCULAR_PROGRESS_INDICATOR_PA_CENTER_DARK_TEXT_STYLE = TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);
const TextStyle CIRCULAR_PROGRESS_INDICATOR_PA_FOOTER_TEXT_STYLE = TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 11.7);

//MARK: - SnackBar
const Duration SNACKBAR_DURATION = Duration(seconds: 2);
const double SNACKBAR_BORDER_RADIUS = 10;
const Color SNACKBAR_ERROR_BACKGROUND_COLOR = Colors.red;
const Color SNACKBAR_ERROR_FOREGROUND_COLOR = Colors.white;
const Color SNACKBAR_SUCCESS_BACKGROUND_COLOR = CUSTOM_BLUE_COLOR;
const Color SNACKBAR_SUCCESS_FOREGROUND_COLOR = Colors.white;
