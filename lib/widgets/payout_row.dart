import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_companion/screens/payout_screen.dart';
import 'package:poker_companion/widgets/text_fields.dart';

class PayoutInputRowWidget extends StatelessWidget {
  const PayoutInputRowWidget({super.key, required this.entry, required this.onChanged, required this.onDelete});
  final PlayerEntry entry;
  final ValueChanged<PlayerEntry> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            child: InputField(
              onChanged: (value) {
                entry.name = value;
                onChanged(entry);
              },
            ),
          ),
          Expanded(
            child: InputField(
              onChanged: (value) {
                entry.moneyIn = double.tryParse(value) ?? 0;
                onChanged(entry);
              },
              hintText: '0.00',
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
            ),
          ),
          Expanded(
            child: InputField(
              onChanged: (value) {
                entry.moneyOut = double.tryParse(value) ?? 0;
                onChanged(entry);
              },
              hintText: '0.00',
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
            ),
          ),
          Expanded(child: OutputField(value: entry.net.toStringAsFixed(2))),
          TextButton(
            onPressed: onDelete,
            child: Text('-', style: TextStyle(fontSize: 30), textAlign: TextAlign.left),
          ),
        ],
      ),
    );
  }
}
