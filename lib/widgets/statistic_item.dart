import 'package:flutter/material.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({super.key, required this.date, required this.pot, required this.playerInfo});
  final DateTime date;
  final double pot;
  final Map<String, (double, double, double)> playerInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(DateTime(2001, 1, 1).toString()),
          Text('pot: 30€'),
          ...playerInfo.entries.map((entry) {
            final String name = entry.key;
            final (double, double, double) values = entry.value;
            return Row(
              children: [
                Text(name),
                Text(values.$1.toString()),
                Text(values.$2.toString()),
                Text(values.$3.toString()),
              ],
            );
          }),
        ],
      ),
    );
  }
}

/*
parts:
  - date: date
  - pot: double from all "in"
  - table:
    - name: string, in: double, out:double, net: double
    - sort by net
*/
