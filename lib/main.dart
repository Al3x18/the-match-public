import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_match/screens/home_screen.dart';
import 'package:the_match/utils/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeMode themeMode = ThemeMode.system;

  //MARK: - Load Theme Mode
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tm = prefs.getString('themeMode');
  switch (tm) {
    case "light":
      themeMode = ThemeMode.light;
      break;
    case "dark":
      themeMode = ThemeMode.dark;
      break;
    case "system":
      themeMode = ThemeMode.system;
      break;
    default:
      themeMode = ThemeMode.system;
  }
  
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Match',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: themeMode,
      home: const HomeScreen(),
    ),
  );
}

ThemeData _buildLightTheme() {
  return ThemeData().copyWith(
    scaffoldBackgroundColor: SCAFFOLD_AND_APP_BAR_BACKGROUND_COLOR,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: SCAFFOLD_AND_APP_BAR_BACKGROUND_COLOR,
      titleTextStyle: GoogleFonts.ibmPlexSans(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    ),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(ThemeData.light().textTheme),
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData().copyWith(
    scaffoldBackgroundColor: SCAFFOLD_AND_APP_BAR_BACKGROUND_COLOR_DARK,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: SCAFFOLD_AND_APP_BAR_BACKGROUND_COLOR_DARK,
      foregroundColor: Colors.white,
     titleTextStyle: GoogleFonts.ibmPlexSans(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
    textTheme: GoogleFonts.ibmPlexSansTextTheme(ThemeData.dark().textTheme),
  );
}
