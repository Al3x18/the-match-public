import 'package:flutter/material.dart';
import 'package:the_match/model/F1/rankings_teams_model.dart';
import 'package:the_match/utils/globals.dart';

class TeamsStandingsList extends StatelessWidget {
  const TeamsStandingsList({super.key, required this.standings});

  final Future<RankingsTeamsModel> standings;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder(
      future: standings,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          debugPrint('Teams List Error: ${snapshot.error.toString()}');
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
                      padding: EdgeInsets.only(bottom: isLastItem ? 40.0 : 14),
                      child: listTileTeam(rankings, isDark),
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

  ListTile listTileTeam(Rankings rankings, bool isDark) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: rankings.position == 1 ? F1_COLOR : Colors.transparent,
        ),
        child: Center(
          child: Text(
            "#${rankings.position.toString()}",
            style: TextStyle(
              color: rankings.position == 1
                  ? Colors.white
                  : isDark
                      ? Colors.white
                      : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 48, height: 40, child: Image.network(rankings.team.logo)),
          const SizedBox(width: 14),
          Flexible(
            flex: 3,
            child: Text(
              rankings.team.name == "Scuderia Ferrari\n" ? "Scuderia Ferrari" : rankings.team.name,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
              ),
            ),
          ),
        ],
      ),
      trailing: Text("${rankings.points.toString()} pts.", style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14.5, fontWeight: FontWeight.w600)),
    );
  }
}
