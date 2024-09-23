// MARK: - Standings Tab
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_match/model/standings/standings_model.dart';
import 'package:the_match/utils/api_reset_countdown/countdown_utils.dart';
import 'package:the_match/utils/globals.dart';
import 'package:the_match/widgets/standings_widgets/shimmer_standings.dart';
import 'package:the_match/widgets/standings_widgets/standings_legend.dart';
import 'package:the_match/widgets/standings_widgets/standings_row.dart';

FutureBuilder<List<StandingsModel>> standingsList({
  required Future<List<StandingsModel>> standings,
  required int countdown,
  required Timer? timer,
}) {
  return FutureBuilder<List<StandingsModel>>(
    future: standings,
    builder: (context, snapshot) {
      final isDark = Theme.of(context).brightness == Brightness.dark;

      if (snapshot.connectionState == ConnectionState.waiting) {
        return shimmerForStandings(isDark: isDark);
      } else if (snapshot.hasError) {
        //debugPrint("Standings List Error: ${snapshot.error.toString()}");
        //MARK: - Start Countdown
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Possible API limit reached.",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Try again in:\n${formatTime(countdown)}",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(
          child: Text('No standings found.'),
        );
      } else {
        //MARK: - Cancel Countdown
        timer?.cancel();
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: buildStandingsLegend(isDark: isDark),
            ),
            SliverList.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final standings = snapshot.data![index];
                final bool isLastItem = index == snapshot.data!.length - 1;
                final bool isFirstItem = index == 0;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: STANDINGS_VERTICAL_PADDING,
                      horizontal: STANDINGS_HORIZONTAL_PADDING),
                  child: Padding(
                    padding: isLastItem
                        ? const EdgeInsets.only(
                            bottom: STANDINGS_LAST_ITEM_PADDING_BOTTOM)
                        : isFirstItem
                            ? const EdgeInsets.only(
                                top: STANDINGS_FIRST_ITEM_PADDING_TOP)
                            : EdgeInsets.zero,
                    child: Column(
                      children: [
                        standingRow(standings, isDark: isDark),
                        const Divider(thickness: STANDINGS_DIVIDER_THICKNESS),
                      ],
                    ),
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
