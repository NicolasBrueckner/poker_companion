import 'package:flutter/material.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/screens/base_screen.dart';
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
    final data = await SessionUtility.load();
    setState(() => _sessions = data);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Statistics',
      child: ListView(children: _sessions.map((s) => StatisticItem(info: s)).toList()),
    );
  }
}

class SessionInfo {
  SessionInfo({String? id, required this.date, required this.table})
    : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();
  final String id;
  final String date;
  List<PlayerEntry> table;
  double get pot => table.fold<double>(0, (sum, p) => sum + p.moneyIn);

  Map<String, dynamic> toJSON() => {
    'id': id as String? ?? DateTime.now().microsecondsSinceEpoch.toString(),
    'date': date as String? ?? '',
    'pot': pot,
    'table': table.map((p) => p.toJSON()).toList(),
  };

  SessionInfo.fromJSON(Map<String, dynamic> j)
    : id = j['id'] ?? DateTime.now().microsecondsSinceEpoch.toString(),
      date = j['date'] ?? '',
      table = (j['table'] as List).map((e) => PlayerEntry.fromJSON(e)).toList();
}
