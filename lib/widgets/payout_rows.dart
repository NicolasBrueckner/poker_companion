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
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
        child: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.primary),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Row(
          spacing: 5,
          children: [
            Expanded(
              flex: 4,
              child: InputField(
                onChanged: (value) {
                  entry.name = value;
                  onChanged(entry);
                },
                isReadOnly: isInputLocked,
                maxLength: 12,
                hintText: 'Name',
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
                keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
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
                keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                isReadOnly: isInputLocked,
              ),
            ),
            Expanded(flex: 3, child: OutputField(value: entry.net.toStringAsFixed(2))),
          ],
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
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              transaction.from,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.arrow_forward, size: 16, color: scheme.onSurface.withValues(alpha: 0.45)),
          ),
          Expanded(
            child: Text(
              transaction.to,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            transaction.amount.toStringAsFixed(2),
            style: TextStyle(fontWeight: FontWeight.w700, color: scheme.primary),
          ),
        ],
      ),
    );
  }
}
