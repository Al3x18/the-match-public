import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:the_match/model/F1/race_model.dart';
import 'package:the_match/screens/race_details.dart';
import 'package:the_match/utils/globals.dart';

class RacesList extends StatelessWidget {
  const RacesList({super.key, required this.races});

  final Future<RacesModel> races;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder(
      future: races,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          debugPrint('Races List Error: ${snapshot.error.toString()}');
          return Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.races.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No races found',
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                ),
                const Text(
                  "Possible API limit reached",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: snapshot.data!.races.length,
                itemBuilder: (context, index) {
                  final bool isLastItem = index == snapshot.data!.races.length - 1;
                  final bool isFirsItem = index == 0;
                  return Padding(
                    padding: EdgeInsets.only(bottom: isLastItem ? 40.0 : 6.0, top: isFirsItem ? 12.0 : 0.0),
                    child: _listTileCircuit(snapshot.data!.races[index], isDark, index),
                  );
                },
              )
            ],
          );
        }
      },
    );
  }

  ListTile _listTileCircuit(Race race, bool isDark, int index) {
    String dateString = race.dateToLocal;
    DateTime parseDate = DateFormat("dd/MM/yyyy HH:mm").parse(dateString);
    bool isDataHigherThanToday = parseDate.isAfter(DateTime.now());

    return ListTile(
      leading: SizedBox(
        height: 60,
        width: 55,
        child: Image.network(
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.red,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          },
          race.circuit.image,
        ),
      ),
      title: Text(
        race.competition.name,
        style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black),
      ),
      subtitle: Text(
        race.dateToLocal,
        style: TextStyle(
          color: isDataHigherThanToday ? F1_COLOR : Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Race ${index + 1}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  Visibility(
                    visible: race.fastestLap!.time != "No Time",
                    child: Text(
                      "FL: ${race.fastestLap!.time}",
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 2.8),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        if (race.date.isAfter(DateTime.now())) {
          Get.closeAllSnackbars();
          Get.snackbar(
            'Details not available',
            'This race has not started yet',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 10,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.to(
            () => RaceDetails(
              raceId: race.id.toString(),
              circuitImage: race.circuit.image,
              circuitName: race.circuit.name,
            ),
          );
        }
      },
    );
  }
}
