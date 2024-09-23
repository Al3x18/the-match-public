import 'package:flutter/material.dart';
import 'package:the_match/widgets/match_widgets/statistics_view/stats_widget.dart';

class MatchStatisticsScreen extends StatefulWidget {
  const MatchStatisticsScreen({super.key, required this.matchId, required this.goalHome, required this.goalAway});

  final int matchId;
  final String goalHome;
  final String goalAway;

  @override
  State<MatchStatisticsScreen> createState() => _MatchStatisticsScreenState();
}

class _MatchStatisticsScreenState extends State<MatchStatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Statistics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              matchStatsWidget(matchId: widget.matchId, goalHome: widget.goalHome, goalAway: widget.goalAway, isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }
}
