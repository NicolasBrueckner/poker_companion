import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_companion/core/payout_data.dart';
import 'package:poker_companion/widgets/text_fields.dart';

class PayoutInputRow extends StatelessWidget {
  const PayoutInputRow({
    super.key,
    required this.entry,
    required this.onChanged,
    required this.onDelete,
    this.isInputLocked = false,
  });
  final PlayerEntry entry;
  final ValueChanged<PlayerEntry> onChanged;
  final DismissDirectionCallback onDelete;
  final bool isInputLocked;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(entry),
      onDismissed: onDelete,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete),
      ),
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            spacing: 5,
            children: [
              Expanded(
                flex: 3,
                child: InputField(
                  onChanged: (value) {
                    entry.name = value;
                    onChanged(entry);
                  },
                  isReadOnly: isInputLocked,
                  maxLength: 12,
                ),
              ),
              Expanded(
                flex: 3,
                child: InputField(
                  onChanged: (value) {
                    entry.moneyIn = double.tryParse(value) ?? 0;
                    onChanged(entry);
                  },
                  hintText: '0.00',
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                  isReadOnly: isInputLocked,
                ),
              ),
              Expanded(
                flex: 3,
                child: InputField(
                  onChanged: (value) {
                    entry.moneyOut = double.tryParse(value) ?? 0;
                    onChanged(entry);
                  },
                  hintText: '0.00',
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                  isReadOnly: isInputLocked,
                ),
              ),
              Expanded(flex: 3, child: OutputField(value: entry.net.toStringAsFixed(2))),
            ],
          ),
        ),
      ),
    );
  }
}

class PayoutOutputRow extends StatelessWidget {
  const PayoutOutputRow({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Expanded(child: OutputField(value: transaction.from)),
        Expanded(child: OutputField(value: transaction.to)),
        Expanded(child: OutputField(value: transaction.amount.toStringAsFixed(2))),
      ],
    );
  }
}
