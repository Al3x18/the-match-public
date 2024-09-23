import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:the_match/utils/globals.dart';

class SelectChampionship extends StatefulWidget {
  const SelectChampionship({super.key});

  @override
  State<StatefulWidget> createState() => _SelectChampionshipState();
}

class _SelectChampionshipState extends State<SelectChampionship> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    TextStyle style = TextStyle(color: isDark ? Colors.white : Colors.black,fontWeight: FontWeight.w500);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Championship'),
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.keyboard_arrow_down, size: 30)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          //MARK: - Football Label
          const Row(
            children: [
              SizedBox(width: 62.7),
              Text("Football", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ListTile(
            title: Text('Serie A', style: style),
            leading: buildLogoImage(LOGO_SERIE_A_IMAGE_PATH),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Map<String, dynamic> values = {'id': '135', 'row1': 'Lega', 'row2': 'Serie A', 'logotype': LOGOTYPE.serieA};
              Get.back<Map<String, dynamic>>(result: values);
            },
          ),
          ListTile(
            title: Text('Premier League', style: style),
            leading: buildLogoImage(isDark ? LOGO_LA_LIGA_DARK_IMAGE_PATH : LOGO_PREMIER_LEAGUE_IMAGE_PATH),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Map<String, dynamic> values = {'id': '39', 'row1': 'Premier', 'row2': 'League', 'logotype': LOGOTYPE.premierLeague};
              Get.back<Map<String, dynamic>>(result: values);
            },
          ),
          ListTile(
            title: Text('La Liga', style: style),
            leading: buildLogoImage(isDark ? LOGO_LA_LIGA_DARK_IMAGE_PATH : LOGO_LA_LIGA_IMAGE_PATH),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Map<String, dynamic> values = {'id': '140', 'row1': 'La', 'row2': 'Liga', 'logotype': LOGOTYPE.laLiga};
              Get.back<Map<String, dynamic>>(result: values);
            },
          ),
          ListTile(
            title: Text('Bundesliga', style: style),
            leading: buildLogoImage(isDark ? LOGO_BUNDES_DARK_IMAGE_PATH : LOGO_BUNDES_IMAGE_PATH),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Map<String, dynamic> values = {'id': '78', 'row1': 'Bundes', 'row2': 'liga', 'logotype': LOGOTYPE.bundesliga};
              Get.back<Map<String, dynamic>>(result: values);
            },
          ),
          ListTile(
            title: Text('Ligue 1', style: style),
            leading: buildLogoImage(isDark ? LOGO_LA_LIGA_DARK_IMAGE_PATH : LOGO_LIGUE_1_IMAGE_PATH),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Map<String, dynamic> values = {'id': '61', 'row1': 'Ligue', 'row2': '1', 'logotype': LOGOTYPE.ligue1};
              Get.back<Map<String, dynamic>>(result: values);
            },
          ),
          const SizedBox(height: 40),
          //MARK: - Others Label
          const Row(
            children: [
              SizedBox(width: 63.2),
              Text("Others", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ],
          ),
          ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Formula 1', style: style),
                const SizedBox(width: 8),
                const Text("(BETA)", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12.8)),
              ],
            ),
            leading: buildLogoImage(isDark ? F1_LOGO_DARK_IMAGE_PATH : F1_LOGO_IMAGE_PATH),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Map<String, dynamic> values = {'id': '00', 'row1': 'F', 'row2': '1', 'logotype': LOGOTYPE.formula1};
              Get.back<Map<String, dynamic>>(result: values);
            },
          ),
        ],
      ),
    );
  }

  SizedBox buildLogoImage(String imagePath) {
    return SizedBox(
      height: 25,
      width: 30,
      child: Image.asset(imagePath),
    );
  }
}
