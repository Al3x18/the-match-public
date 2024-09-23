import 'package:flutter/material.dart';
import 'package:the_match/utils/F1_utils/fetch_race_result.dart';
import 'package:the_match/utils/globals.dart';

class RaceDetails extends StatelessWidget {
  const RaceDetails({super.key, required this.raceId, required this.circuitImage, required this.circuitName});

  final String raceId;
  final String circuitImage;
  final String circuitName;

@override
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Scaffold(
    appBar: AppBar(
      title: Text(circuitName),
    ),
    body: FutureBuilder(
      future: fetchRacesResult(raceId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          debugPrint('Races List Error: ${snapshot.error.toString()}');
          return const Center(
            child: Text('Something went wrong'),
          );
        } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return const Center(
            child: Text('No races found'),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.network(
                        circuitImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final result = snapshot.data!.results[index];
                    final isLastItem = index == snapshot.data!.results.length - 1;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLastItem ? 40.0 : 8.0),
                      child: driverResultsRow(
                        position: result.position.toString(),
                        driverName: result.driver.name,
                        team: result.team.name,
                        time: result.time,
                        grid: result.grid,
                        pits: result.pits.toString(),
                        isDark: isDark,
                      ),
                    );
                  },
                  childCount: snapshot.data!.results.length,
                ),
              ),
            ],
          );
        }
      },
    ),
  );
}

  ListTile driverResultsRow({
    required String position,
    required String driverName,
    required String team,
    required String time,
    required String grid,
    required String pits,
    bool isDark = false,
  }) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: int.tryParse(position) == 1 ? F1_COLOR : Colors.transparent,
            ),
            child: Center(
              child: Text(
                "#$position",
                style: TextStyle(color: int.tryParse(position) == 1 ? Colors.white : isDark ? Colors.white : Colors.black, 
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              driverName,
              style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  team == "Scuderia Ferrari\n" ? "Scuderia Ferrari" : team,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          ),
          Text(
            "Grid: $grid",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          Text(
            "Pits: $pits",
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 14.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
