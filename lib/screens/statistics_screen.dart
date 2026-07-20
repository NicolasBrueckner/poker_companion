import 'package:flutter/material.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/payout_screen.dart';
import 'package:poker_companion/widgets/statistic_item.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatefulWidget> createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  List<SessionInfo> _sessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final data = await SessionUtility().load();
    setState(() => _sessions = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: ListView(children: _sessions.map((s) => StatisticItem(info: s)).toList()),
    );
  }
}

class SessionInfo {
  SessionInfo({required this.date, required this.table});
  final String date;
  final List<PlayerEntry> table;
  double get pot => table.fold<double>(0, (sum, p) => sum + p.moneyIn);

  Map<String, dynamic> toJSON() => {'date': date, 'pot': pot, 'table': table.map((p) => p.toJSON()).toList()};

  SessionInfo.fromJSON(Map<String, dynamic> j)
    : date = j['date'],
      table = (j['table'] as List).map((e) => PlayerEntry.fromJSON(e)).toList();
}
