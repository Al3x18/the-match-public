import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_match/utils/globals.dart';

void changeThemeMode(SEGMENTS selectedSegment) {
  switch (selectedSegment) {
    case SEGMENTS.light:
      Get.changeThemeMode(ThemeMode.light);
      break;
    case SEGMENTS.dark:
      Get.changeThemeMode(ThemeMode.dark);
      break;
    case SEGMENTS.system:
      Get.changeThemeMode(ThemeMode.system);
      break;
    default:
      Get.changeThemeMode(ThemeMode.system);
  }
}

Future<SEGMENTS> loadThemeMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SEGMENTS selectedSegment;
  selectedSegment = prefs.getString('themeMode') == 'light'
      ? SEGMENTS.light
      : prefs.getString('themeMode') == 'dark'
          ? SEGMENTS.dark
          : SEGMENTS.system;

  return selectedSegment;
}

  void saveThemeMode(SEGMENTS selectedSegment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (selectedSegment) {
      case SEGMENTS.light:
        prefs.setString('themeMode', 'light');
        break;
      case SEGMENTS.dark:
        prefs.setString('themeMode', 'dark');
        break;
      case SEGMENTS.system:
        prefs.setString('themeMode', 'system');
        break;
      default:
        prefs.setString('themeMode', 'system');
    }
  }
