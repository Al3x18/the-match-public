// MARK: - Matches Tab
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_match/model/match/match_model.dart';
import 'package:the_match/screens/match_stats_screen.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/widgets/match_widgets/match_card.dart';
import 'package:the_match/widgets/match_widgets/match_time.dart';
import 'package:the_match/widgets/match_widgets/shimmer_matches.dart';

FutureBuilder<List<MatchModel>> matchesList({
  required bool isDayNameVisible,
  required Future<List<MatchModel>> matches,
  required String seasonYear,
  required LOGOTYPE appLogotype,
}) {
  void openMatchDetails(int id, String goalHome, String goalAway) {
    Get.to(
      () => MatchStatisticsScreen(
        matchId: id,
        goalHome: goalHome,
        goalAway: goalAway,
      ),
    );
  }

  return FutureBuilder<List<MatchModel>>(
    future: matches,
    builder: (context, snapshot) {
      final isDark = Theme.of(context).brightness == Brightness.dark;

      if (snapshot.connectionState == ConnectionState.waiting) {
        return shimmerLoadForMatches(isDark: isDark);
      } else if (snapshot.hasError) {
        //debugPrint('Matches List Error: ${snapshot.error.toString()}');
        return const Center(
          child: Text('Something went wrong'),
        );
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No matches found.',
                style: TextStyle(fontSize: 16, color: isDark ? Colors.white : Colors.black),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: isDark ? Colors.white : Colors.transparent,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Swipe for more"), SizedBox(width: 5), Icon(Icons.arrow_right_alt)],
                ),
              )
            ],
          ),
        );
      } else {
        return CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final MatchModel match = snapshot.data![index];
                final bool isLastItem = index == snapshot.data!.length - 1;
                final bool isFirstItem = index == 0;
                return Padding(
                  padding: EdgeInsets.only(
                    top: isFirstItem ? 6.0 : 0.0,
                    bottom: isLastItem ? 40.0 : 0.0,
                  ),
                  child: Row(
                    children: [
                      matchTime(
                        dataDayMonth: match.dateDayMonth,
                        dataHourMin: match.dateHourMinute,
                        isDayNameVisible: isDayNameVisible,
                        dateDay: match.dateDay,
                        appLogotype: appLogotype,
                        isDark: isDark,
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            int? seasonYtoInt = int.tryParse(seasonYear);
                            if (
                            match.status == "Not Started" 
                            || match.status == "Time to be defined"
                            || seasonYtoInt! < 2016
                            ) {
                              Get.closeAllSnackbars();
                              Get.snackbar(
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: SNACKBAR_SUCCESS_FOREGROUND_COLOR,
                                backgroundColor: SNACKBAR_SUCCESS_BACKGROUND_COLOR,
                                borderRadius: SNACKBAR_BORDER_RADIUS,
                                "Match stats not available",
                                "Match has not started yet or stats are not available for this season.\n(stats available from 2016)",
                              );
                              return;
                            }
                            openMatchDetails(match.fixtureId, match.homeGoals.toString(), match.awayGoals.toString());
                          },
                          child: matchCard(
                            teamHomeLogoPath: match.homeTeamLogo,
                            teamAwayLogoPath: match.awayTeamLogo,
                            homeGoals: match.homeGoals.toString(),
                            awayGoals: match.awayGoals.toString(),
                            status: match.status,
                            timeElapsed: match.timeElapsed,
                            appLogotype: appLogotype,
                            isDark: isDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      }
    },
  );
}
