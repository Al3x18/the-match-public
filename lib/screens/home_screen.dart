import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_match/delegates/silver_header_delegate.dart';
import 'package:the_match/model/F1/race_model.dart';
import 'package:the_match/model/F1/rankings_drivers_model.dart';
import 'package:the_match/model/F1/rankings_teams_model.dart';
import 'package:the_match/model/match/match_model.dart';
import 'package:the_match/model/standings/standings_model.dart';
import 'package:the_match/screens/select_championship.dart';
import 'package:the_match/screens/set_f1_season.dart';
import 'package:the_match/screens/set_football_season_year.dart';
import 'package:the_match/screens/settings_screen.dart';
import 'package:the_match/utils/F1_utils/fetch_drivers_standings.dart';
import 'package:the_match/utils/F1_utils/fetch_races.dart';
import 'package:the_match/utils/F1_utils/fetch_teams_standings.dart';
import 'package:the_match/utils/api_reset_countdown/countdown_utils.dart';
import 'package:the_match/utils/match_utils/fetch_matches.dart';
import 'package:the_match/utils/notifiers/value_notifier.dart';
import 'package:the_match/utils/standings_utils/fetch_standings.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/widgets/F1_widgets/drivers_standings_widget.dart';
import 'package:the_match/widgets/F1_widgets/races_list_widget.dart';
import 'package:the_match/widgets/F1_widgets/teams_standings_list_widget.dart';
import 'package:the_match/widgets/championship_logo/build_championship_logo.dart';
import 'package:the_match/widgets/match_widgets/match_select_round.dart';
import 'package:the_match/widgets/match_widgets/matches_list.dart';
import 'package:the_match/widgets/standings_widgets/standings_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late Future<List<MatchModel>> matches;
  late Future<List<StandingsModel>> standings;
  late Future<RacesModel> races;
  late Future<RankingsTeamsModel> f1TeamsStandings;
  late Future<DriverStandingsModel> f1DriversStandings;

  late bool _hapticFeedbackValue;
  late bool _showDayNameValue;

  Timer? _timer;
  int _countdown = 0;

  String leagueId = '135';
  String seasonYear = '2024';
  int round = 1;

  Widget _defaultLogo = const BuildChampionshipLogo(textRow1: "Lega", textRow2: "Serie A", logotype: LOGOTYPE.serieA);
  LOGOTYPE _appLogotype = LOGOTYPE.serieA;
  Color _appColor = CUSTOM_BLUE_COLOR;

  bool _isSeasonYearTapped = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    _onInit();
  }

  void _onInit() {
    _loadSettings();

    matches = fetchMatches(league: leagueId, season: seasonYear, round: round.toString());
    standings = fetchStandings(league: leagueId, season: seasonYear);

    races = fetchRaces(seasonYear);
    f1TeamsStandings = fetchTeamsStandings(seasonYear);
    f1DriversStandings = fetchDriversStandings(seasonYear);

    setState(() {});
  }

  void _refresh(LOGOTYPE logotype) {
    if (logotype != LOGOTYPE.formula1) {
      matches = fetchMatches(league: leagueId, season: seasonYear, round: round.toString());
      standings = fetchStandings(league: leagueId, season: seasonYear);
    } else {
      races = fetchRaces(seasonYear);
      f1TeamsStandings = fetchTeamsStandings(seasonYear);
      f1DriversStandings = fetchDriversStandings(seasonYear);
    }
    setState(() {});
  }

  void _loadMatchesAndStandings(String id) {
    setState(() {
      leagueId = id;
      matches = fetchMatches(league: id, season: seasonYear, round: round.toString());
      standings = fetchStandings(league: id, season: seasonYear);
    });
  }

  void _loadF1RacesAndStandings() {
    setState(() {
      races = fetchRaces(seasonYear);
      f1TeamsStandings = fetchTeamsStandings(seasonYear);
      f1DriversStandings = fetchDriversStandings(seasonYear);
    });
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _hapticFeedbackValue = prefs.getBool('isHapticFeedbackEnabled') ?? false;
    _showDayNameValue = prefs.getBool('isDayNameEnabled') ?? false;

    hapticFeedbackNotifier.value = _hapticFeedbackValue;
    showDayNameNotifier.value = _showDayNameValue;
  }

  void _startCountdown() {
    setState(() {
      _countdown = setCountdownToNext2AM(_countdown);
    });

    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (timer) {
      if (_countdown == 0) {
        timer.cancel();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void _setAppColor() {
    if (_appLogotype == LOGOTYPE.serieA) {
      _appColor = CUSTOM_BLUE_COLOR;
    } else if (_appLogotype == LOGOTYPE.premierLeague) {
      _appColor = PREMIER_LEAGUE_COLOR;
    } else if (_appLogotype == LOGOTYPE.laLiga) {
      _appColor = LA_LIGA_COLOR;
    } else if (_appLogotype == LOGOTYPE.ligue1) {
      _appColor = LIGUE_1_COLOR;
    } else if (_appLogotype == LOGOTYPE.formula1) {
      _appColor = F1_COLOR;
    } else if (_appLogotype == LOGOTYPE.bundesliga) {
      _appColor = BUNDESLIGA_COLOR;
    }

    setState(() {});
  }

  double _setHeaderMaxHeight() {
    double maxHeight = 0.0;

     if (_appLogotype == LOGOTYPE.serieA) {
      maxHeight = 127.0;
    } else if (_appLogotype == LOGOTYPE.premierLeague) {
      maxHeight = 119.7;
    } else if (_appLogotype == LOGOTYPE.laLiga) {
      maxHeight = 128.8;
    } else if (_appLogotype == LOGOTYPE.ligue1) {
      maxHeight = 122.5;
    } else if (_appLogotype == LOGOTYPE.formula1) {
      maxHeight = 105.55;
    } else if (_appLogotype == LOGOTYPE.bundesliga) {
      maxHeight = 106.4;
    }

    return maxHeight;
  }

  double _setHeaderLeftPadding() {
    double padding = 0.0;

    if (_appLogotype == LOGOTYPE.serieA) {
      padding = 6.6;
    } else if (_appLogotype == LOGOTYPE.premierLeague) {
      padding = 0.0;
    } else if (_appLogotype == LOGOTYPE.laLiga) { 
      padding = 11.5;
    } else if (_appLogotype == LOGOTYPE.ligue1) {
      padding = 4.5;
    } else if (_appLogotype == LOGOTYPE.formula1) {
      padding = 8.75;
    } else if (_appLogotype == LOGOTYPE.bundesliga) {
      padding = 3.0;
    }

    return padding;
  }

  double _setHeaderShimmerBottomPadding() {
    double padding = 0.0;

    if (_appLogotype == LOGOTYPE.serieA) {
      padding = .0;
    } else if (_appLogotype == LOGOTYPE.premierLeague) {
      padding = 4.2;
    } else if (_appLogotype == LOGOTYPE.laLiga) {
      padding = 3.0;
    } else if (_appLogotype == LOGOTYPE.ligue1) {
      padding = 8.5;
    } else if (_appLogotype == LOGOTYPE.formula1) {
      padding = .0;
    } else if (_appLogotype == LOGOTYPE.bundesliga) {
      padding = .0;
    }

    return padding;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // It works don't touch it!
    if (isDark && _appLogotype == LOGOTYPE.serieA) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Lega", textRow2: "Serie A", logotype: LOGOTYPE.serieA, isDark: isDark);
      _setAppColor();
    } else if (isDark && _appLogotype == LOGOTYPE.premierLeague) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Premier", textRow2: "League", logotype: LOGOTYPE.premierLeague, isDark: isDark);
      _setAppColor();
    } else if (isDark && _appLogotype == LOGOTYPE.laLiga) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "La", textRow2: "Liga", logotype: LOGOTYPE.laLiga, isDark: isDark);
      _setAppColor();
    } else if (isDark && _appLogotype == LOGOTYPE.ligue1) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Ligue", textRow2: "1", logotype: LOGOTYPE.ligue1, isDark: isDark);
      _setAppColor();
    } else if (isDark && _appLogotype == LOGOTYPE.formula1) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "F", textRow2: "1", logotype: LOGOTYPE.formula1, isDark: isDark);
      _setAppColor();
    } else if (isDark && _appLogotype == LOGOTYPE.bundesliga) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Bundes", textRow2: "liga", logotype: LOGOTYPE.bundesliga, isDark: isDark);
      _setAppColor();
    }

    // View comment up...
    if (!isDark && _appLogotype == LOGOTYPE.serieA) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Lega", textRow2: "Serie A", logotype: LOGOTYPE.serieA, isDark: isDark);
      _setAppColor();
    } else if (!isDark && _appLogotype == LOGOTYPE.premierLeague) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Premier", textRow2: "League", logotype: LOGOTYPE.premierLeague, isDark: isDark);
      _setAppColor();
    } else if (!isDark && _appLogotype == LOGOTYPE.laLiga) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "La", textRow2: "Liga", logotype: LOGOTYPE.laLiga, isDark: isDark);
      _setAppColor();
    } else if (!isDark && _appLogotype == LOGOTYPE.ligue1) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Ligue", textRow2: "1", logotype: LOGOTYPE.ligue1, isDark: isDark);
      _setAppColor();
    } else if (!isDark && _appLogotype == LOGOTYPE.formula1) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "F", textRow2: "1", logotype: LOGOTYPE.formula1, isDark: isDark);
      _setAppColor();
    } else if (!isDark && _appLogotype == LOGOTYPE.bundesliga) {
      _defaultLogo = BuildChampionshipLogo(textRow1: "Bundes", textRow2: "liga", logotype: LOGOTYPE.bundesliga, isDark: isDark);
      _setAppColor();
    }

    return DefaultTabController(
      length: _appLogotype == LOGOTYPE.formula1 ? 3 : 2,
      child: ValueListenableBuilder(
        valueListenable: hapticFeedbackNotifier,
        builder: (context, hapticValue, child) {
          return ValueListenableBuilder(
            valueListenable: showDayNameNotifier,
            builder: (context, dayNameValue, child) {
              return Scaffold(
                body: CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      title: const Text("The Match"),
                      floating: true,
                      pinned: true,
                      leading: IconButton(
                        onPressed: () => _refresh(_appLogotype),
                        icon: Icon(
                          CupertinoIcons.refresh,
                          color: isDark ? Colors.white : _appColor,
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () => Get.to(() => const SettingsScreen()),
                          icon: Icon(
                            CupertinoIcons.settings,
                            color: isDark ? Colors.white : _appColor,
                          ),
                        ),
                      ],
                    ),
                    //MARK: - HEADER
                    SliverPersistentHeader(
                      pinned: false,
                      floating: false,
                      delegate: SilverHeaderDelegate(
                        minHeight: 0,
                        maxHeight: _setHeaderMaxHeight(),
                        child: Padding(
                          padding: EdgeInsets.only(right: 16, left: _setHeaderLeftPadding()),
                          //MARK: - Build Logo
                          child: GestureDetector(
                            onTap: () async {
                              Map<String, dynamic>? values = await Get.to(() => const SelectChampionship(), transition: Transition.downToUp, curve: Curves.fastEaseInToSlowEaseOut, popGesture: false);
                              if (values != null) {
                                String id = values['id'];
                                String textRow1 = values['row1'];
                                String textRow2 = values['row2'];
                                LOGOTYPE logotype = values['logotype'];
                                setState(() {
                                  _setAppColor();
                                  _defaultLogo = BuildChampionshipLogo(textRow1: textRow1, textRow2: textRow2, logotype: logotype, isDark: isDark);
                                  _appLogotype = logotype;
                                  if (leagueId != id && _appLogotype != LOGOTYPE.formula1) {
                                    _loadMatchesAndStandings(id);
                                  }
                                });
                              } else if (_appLogotype == LOGOTYPE.formula1) {
                                _loadF1RacesAndStandings();
                              } else {
                                return;
                              }
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 12.4, bottom: _setHeaderShimmerBottomPadding()),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: isDark ? Colors.white : Colors.black87,
                                    child: const Text(
                                      "Tap to change championship",
                                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _defaultLogo,
                                    _buildCustomSeasonButton(hapticValue, isDark: isDark),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      //MARK: - Tab Bar
                      child: TabBar(
                        splashBorderRadius: BorderRadius.circular(TAB_BAR_SPLASH_RADIUS),
                        indicatorColor: isDark ? Colors.white : _appColor,
                        tabs: [
                          //MARK: - Tab Matchday
                          if (_appLogotype != LOGOTYPE.formula1)
                            Tab(
                              child: GestureDetector(
                                onLongPress: () async {
                                  final canVibrate = await Haptics.canVibrate();
                                  if (canVibrate && hapticValue) {
                                    await Haptics.vibrate(HapticsType.soft);
                                  }
                                  if (!context.mounted) return;
                                  final int? selectedRound;

                                  if (Platform.isIOS) {
                                    selectedRound = await cupertinoRoundModalPopup(context);
                                  } else {
                                    selectedRound = await androidRoundPopMenu(context);
                                  }

                                  if (selectedRound != null) {
                                    setState(() {
                                      round = selectedRound!;
                                      matches = fetchMatches(league: leagueId, season: seasonYear, round: round.toString());
                                    });
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Matchday $round",
                                      style: TextStyle(
                                        color: isDark ? Colors.white : _appColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: isDark ? Colors.white : Colors.transparent,
                                      child: const Text(
                                        "Long press to change",
                                        style: TextStyle(color: Colors.grey, fontSize: 9.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          //MARK: - Tab Standings
                          if (_appLogotype != LOGOTYPE.formula1)
                            Tab(
                              child: Text(
                                "Standings",
                                style: TextStyle(
                                  color: isDark ? Colors.white : _appColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          //MARK: - Tab Race
                          if (_appLogotype == LOGOTYPE.formula1)
                            Tab(
                              child: Text(
                                "Races",
                                style: TextStyle(
                                  color: isDark ? Colors.white : _appColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          //MARK: - Tab Driver
                          if (_appLogotype == LOGOTYPE.formula1)
                            Tab(
                              child: Text(
                                "Driver Standings",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark ? Colors.white : _appColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          //MARK: - Tab Team
                          if (_appLogotype == LOGOTYPE.formula1)
                            Tab(
                              child: Text(
                                "Team Standings",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isDark ? Colors.white : _appColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    //MARK: - Tab Bar View
                    SliverFillRemaining(
                      child: TabBarView(
                        children: [
                          if (_appLogotype != LOGOTYPE.formula1)
                            matchesList(
                              isDayNameVisible: dayNameValue,
                              seasonYear: seasonYear,
                              matches: matches,
                              appLogotype: _appLogotype,
                            ),
                          if (_appLogotype != LOGOTYPE.formula1)
                            standingsList(
                              standings: standings,
                              countdown: _countdown,
                              timer: _timer,
                            ),
                          if (_appLogotype == LOGOTYPE.formula1) RacesList(races: races),
                          if (_appLogotype == LOGOTYPE.formula1) DriversStandingsList(standings: f1DriversStandings),
                          if (_appLogotype == LOGOTYPE.formula1) TeamsStandingsList(standings: f1TeamsStandings),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

//MARK: - Custom Season Button
  GestureDetector _buildCustomSeasonButton(bool hapticValue, {bool isDark = false}) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isSeasonYearTapped = true;
        });

        final canVibrate = await Haptics.canVibrate();
        if (canVibrate && hapticValue) {
          await Haptics.vibrate(HapticsType.soft);
        }

        String? newSeasonYear;
        //MARK: - Set Season Year
        if (_appLogotype != LOGOTYPE.formula1) {
          newSeasonYear = await Get.to(() => SetFootballSeasonYear(currentSeasonYear: seasonYear));
        } else if (_appLogotype == LOGOTYPE.formula1) {
          newSeasonYear = await Get.to(() => SetF1SeasonYear(currentSeasonYear: seasonYear));
        }

        if (newSeasonYear != seasonYear && newSeasonYear != null && _appLogotype != LOGOTYPE.formula1) {
          setState(() {
            seasonYear = newSeasonYear!;

            matches = fetchMatches(league: leagueId, season: seasonYear, round: round.toString());
            standings = fetchStandings(league: leagueId, season: seasonYear);
          });
        } else if (newSeasonYear != seasonYear && newSeasonYear != null && _appLogotype == LOGOTYPE.formula1) {
          setState(() {
            seasonYear = newSeasonYear!;

            races = fetchRaces(seasonYear);
            f1TeamsStandings = fetchTeamsStandings(seasonYear);
            f1DriversStandings = fetchDriversStandings(seasonYear);
          });
        }

        setState(() {
          _isSeasonYearTapped = false;
        });
      },
      onTapDown: (details) {
        setState(() {
          _isSeasonYearTapped = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isSeasonYearTapped = false;
        });
      },
      child: Text(
        _appLogotype != LOGOTYPE.formula1 ? "Season\n$seasonYear/${int.parse(seasonYear.substring(2)) + 1}" : "Season\n$seasonYear",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.5,
          color: isDark ? (_isSeasonYearTapped ? Colors.white.withOpacity(0.5) : Colors.white) : (_isSeasonYearTapped ? _appColor.withOpacity(0.5) : _appColor),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
