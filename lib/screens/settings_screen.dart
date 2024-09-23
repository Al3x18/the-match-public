import 'package:flutter/material.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/utils/notifiers/value_notifier.dart';
import 'package:the_match/utils/settings_utils/theme_utils.dart';
import 'package:the_match/utils/settings_utils/launch_link_in_web_view.dart';
import 'package:the_match/utils/settings_utils/send_email.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String version = "Unknown";
  String buildNumber = "Unknown";
  bool isHapticFeedbackEnabled = hapticFeedbackNotifier.value;
  bool isDayNameEnabled = showDayNameNotifier.value;
  String year = DateTime.now().year.toString();
  bool isDevNameTapped = false;

   SEGMENTS _selectedSegment = SEGMENTS.system;

  @override
  void initState() {
    _initVariables();
    super.initState();
  }

  void _initVariables() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    isHapticFeedbackEnabled = prefs.getBool('isHapticFeedbackEnabled') ?? false;
    isDayNameEnabled = prefs.getBool('isDayNameEnabled') ?? false;
    _selectedSegment = await loadThemeMode();

    setState(() {});
  }

  void _saveHapticFeedbackValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isHapticFeedbackEnabled', value);
  }

  void _saveDayNameValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDayNameEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //MARK: - App Version
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(LIST_TILE_IMAGE_ASSET_RADIUS),
                  child: Image.asset(
                    isDark ? DARK_LIST_TILE_APP_VERSION_IMAGE_ASSET_PATH : LIST_TILE_APP_VERSION_IMAGE_ASSET_PATH,
                    width: LIST_TILE_IMAGE_ASSET_WIDTH_AND_HEIGHT,
                    height: LIST_TILE_IMAGE_ASSET_WIDTH_AND_HEIGHT,
                  ),
                ),
                title: Text(
                  "App Version",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: LIST_TILE_FONT_SIZE,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                trailing: Text(
                  version,
                  style: TextStyle(fontSize: LIST_TILE_FONT_SIZE, color: isDark ? Colors.white : Colors.black),
                ),
                subtitle: Text("Build Number: $buildNumber", style: const TextStyle(color:Colors.grey, fontSize: SUBTITLE_TEXT_FONT_SIZE)),
              ),
              //MARK: - Report Issue
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(LIST_TILE_IMAGE_ASSET_RADIUS),
                  child: Image.asset(
                    isDark ? DARK_LIST_TILE_SEND_MAIL_IMAGE_PATH : LIST_TILE_SEND_MAIL_IMAGE_PATH,
                    width: LIST_TILE_IMAGE_ASSET_WIDTH_AND_HEIGHT,
                    height: LIST_TILE_IMAGE_ASSET_WIDTH_AND_HEIGHT,
                  ),
                ),
                title: Text(
                  "Report an Issue",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: LIST_TILE_FONT_SIZE, color: isDark ? Colors.white : Colors.black),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: ARROW_ICON_SIZE, color: Colors.grey),
                subtitle: const Text(
                  "Send an email to Dev Team",
                  style: TextStyle(color: Colors.grey, fontSize: SUBTITLE_TEXT_FONT_SIZE),
                ),
                onTap: sendEmailToDevTeam,
              ),
              //MARK: - Show day name
              SwitchListTile.adaptive(
                thumbIcon: WidgetStatePropertyAll(
                  Icon(
                    Icons.view_day_outlined,
                    color: isDayNameEnabled
                        ? Colors.black
                        : isDark
                            ? Colors.black
                            : Colors.white,
                  ),
                ),
                activeColor: CUSTOM_BLUE_COLOR,
                inactiveThumbColor: Colors.black,
                thumbColor: WidgetStatePropertyAll(
                  isDark ? (isDayNameEnabled ? Colors.white : Colors.grey) : (isDayNameEnabled ? Colors.white : Colors.black),
                ),
                title: Text(
                  "${isDayNameEnabled ? "Disable" : "Enable"} Day Name in Matches List",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: LIST_TILE_FONT_SIZE,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Text(
                  "The name of the day is displayed above the date and time of the matches",
                  style: TextStyle(
                    fontSize: SUBTITLE_TEXT_FONT_SIZE,
                    color: Colors.grey.shade500,
                  ),
                ),
                value: isDayNameEnabled,
                onChanged: (value) {
                  setState(() {
                    isDayNameEnabled = value;
                    showDayNameNotifier.value = value;
                    _saveDayNameValue(value);
                  });
                },
              ),

              //MARK: - Haptic Feedback
              SwitchListTile.adaptive(
                thumbIcon: WidgetStatePropertyAll(
                  Icon(
                    Icons.vibration,
                    color: isHapticFeedbackEnabled
                        ? Colors.black
                        : isDark
                            ? Colors.black
                            : Colors.white,
                  ),
                ),
                activeColor: CUSTOM_BLUE_COLOR,
                inactiveThumbColor: Colors.black,
                thumbColor: WidgetStatePropertyAll(
                  isDark ? (isHapticFeedbackEnabled ? Colors.white : Colors.grey) : (isHapticFeedbackEnabled ? Colors.white : Colors.black),
                ),
                title: Text(
                  "${isHapticFeedbackEnabled ? "Disable" : "Enable"} Haptic Feedback",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: LIST_TILE_FONT_SIZE,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Text(
                  "When you long press Matchday in the Tab Bar or Season Button",
                  style: TextStyle(
                    fontSize: SUBTITLE_TEXT_FONT_SIZE,
                    color: Colors.grey.shade500,
                  ),
                ),
                value: isHapticFeedbackEnabled,
                onChanged: (value) async {
                  final canVibrate = await Haptics.canVibrate();
                  if (canVibrate && value) {
                    await Haptics.vibrate(HapticsType.soft);
                  }
                  setState(() {
                    isHapticFeedbackEnabled = value;
                    hapticFeedbackNotifier.value = value;
                    _saveHapticFeedbackValue(value);
                  });
                },
              ),
              const SizedBox(height: 8),
              //MARK: - Theme Selection
              Column(
                children: [
                  const Text("SELECT THEME MODE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                  SegmentedButton<SEGMENTS>(
                    segments: const [
                      ButtonSegment(value: SEGMENTS.light, label: Text("Light"), icon: Icon(Icons.wb_sunny_outlined)),
                      ButtonSegment(value: SEGMENTS.system, label: Text("System"), icon: Icon(Icons.sync)),
                      ButtonSegment(value: SEGMENTS.dark, label: Text("Dark"), icon: Icon(Icons.brightness_2_outlined)),
                    ],
                    selected: <SEGMENTS>{_selectedSegment},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        _selectedSegment = newSelection.first;
                        changeThemeMode(_selectedSegment);
                        saveThemeMode(_selectedSegment);
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                        // selected button color
                        if (states.contains(WidgetState.selected)) {
                          return isDark ? Colors.grey.shade600 : CUSTOM_BLUE_COLOR;
                        }
                        // unselected button color
                        return isDark ? Colors.black : Colors.white;
                      }),
                      // text and icon color for selected button
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.white;
                        }
                        // text and icon color for unselected button
                        return isDark ? Colors.grey : Colors.black;
                      }),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              bottomDevName(isDevNameTapped),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomDevName(bool isDevTapped) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDevNameTapped = true;
        });

        launchInWebView(GITHUB_URL);

        setState(() {
          isDevNameTapped = false;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Developed by:",
            style: TextStyle(fontSize: DEV_NAME_FONT_SIZE, color: isDevTapped ? DEV_NAME_FONT_COLOR.withOpacity(0.5) : DEV_NAME_FONT_COLOR),
          ),
          Text(
            "Alex De Pasquale",
            style: TextStyle(fontSize: DEV_NAME_FONT_SIZE, color: isDevTapped ? DEV_NAME_FONT_COLOR.withOpacity(0.5) : DEV_NAME_FONT_COLOR),
          ),
          Text(
            "Copyright © $year",
            style: TextStyle(fontSize: 10, color: isDevTapped ? DEV_NAME_FONT_COLOR.withOpacity(0.5) : DEV_NAME_FONT_COLOR),
          ),
          const SizedBox(height: 5),
        ],
      ),
      onTapDown: (_) {
        setState(() {
          isDevNameTapped = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isDevNameTapped = false;
        });
      },
    );
  }
}
