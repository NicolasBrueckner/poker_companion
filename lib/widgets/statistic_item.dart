import 'package:flutter/material.dart';
import 'package:poker_companion/screens/statistics_screen.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem({super.key, required this.info});
  final SessionInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: Colors.black,
          width: 2,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Column(
        children: [
          Text(info.date),
          Text(info.pot.toString()),
          ...info.table.map((entry) {
            return Row(
              children: [
                Text(entry.name),
                Text(entry.moneyIn.toString()),
                Text(entry.moneyOut.toString()),
                Text(entry.net.toString()),
              ],
            );
          }),
        ],
      ),
    );
  }
}
