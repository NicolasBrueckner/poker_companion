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

  Future<void> _deleteSession(String id) async {
    final sessions = await SessionUtility.load();
    sessions.removeWhere((s) => s.id == id);
    await SessionUtility.save(sessions);
    setState(() => _sessions = sessions);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Statistics',
      child: _sessions.isEmpty
          ? Center(
              child: Text(
                'No sessions saved yet',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _sessions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final session = _sessions[_sessions.length - 1 - i];
                return StatisticItem(
                  info: session,
                  onDelete: () => _deleteSession(session.id),
                );
              },
            ),
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
    'id': id,
    'date': date,
    'pot': pot,
    'table': table.map((p) => p.toJSON()).toList(),
  };

  SessionInfo.fromJSON(Map<String, dynamic> j)
    : id = j['id'] ?? DateTime.now().microsecondsSinceEpoch.toString(),
      date = j['date'] ?? '',
      table = (j['table'] as List).map((e) => PlayerEntry.fromJSON(e)).toList();
}
