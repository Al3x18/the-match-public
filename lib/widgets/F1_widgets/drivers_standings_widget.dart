import 'package:flutter/material.dart';
import 'package:the_match/model/F1/rankings_drivers_model.dart';
import 'package:the_match/utils/globals.dart';

class DriversStandingsList extends StatelessWidget {
  const DriversStandingsList({super.key, required this.standings});

  final Future<DriverStandingsModel> standings;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder(
      future: standings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          debugPrint('Drivers List Error: ${snapshot.error.toString()}');
          return Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.rankings.isEmpty) {
          return Center(
            child: Text('No Teams standings found', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final rankings = snapshot.data!.rankings[index];
                    final bool isLastItem = index == snapshot.data!.rankings.length - 1;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLastItem ? 40.0 : 4.0),
                      child: listTileDriver(rankings, isDark),
                    );
                  },
                  childCount: snapshot.data!.rankings.length,
                ),
              )
            ],
          );
        }
      },
    );
  }

  ListTile listTileDriver(DriverRanking rankings, bool isDark) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: rankings.position == 1 ? F1_COLOR : Colors.transparent,
            ),
            child: Center(
              child: Text(
                "#${rankings.position.toString()}",
                style: TextStyle(color: rankings.position == 1 ? Colors.white : isDark ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Image.network(
            rankings.driver.image,
            width: 40.5,
            height: 40.5,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                width: 42,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              width: 42,
              child: Text(
                "No Image Found",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        rankings.driver.name,
        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              rankings.team.name == "Scuderia Ferrari\n" ? "Scuderia Ferrari" : rankings.team.name,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Text(
            "${rankings.wins.toString()} Wins",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${rankings.points.toString()} pts.",
            style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Text(
            rankings.behind.toString() == "0" ? "0" : "- ${rankings.behind.toString()}",
            style: const TextStyle(color: Colors.grey, fontSize: 13.8, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
