import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_companion/core/utility.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.isReadOnly = false,
    this.onChanged,
    this.maxLength = 8,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.hintText,
  });
  final bool isReadOnly;
  final ValueChanged<String>? onChanged;
  final int maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return TextField(
      readOnly: isReadOnly,
      onChanged: onChanged,
      maxLength: maxLength,
      style: TextStyle(color: isReadOnly ? scheme.onSurface : scheme.onPrimary),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      decoration: _payoutFieldDecoration(scheme: scheme, isReadOnly: isReadOnly, hintText: hintText),
    );
  }
}

class OutputField extends StatefulWidget {
  const OutputField({super.key, required this.value});
  final String value;

  @override
  State<OutputField> createState() => _OutputFieldState();
}

class _OutputFieldState extends State<OutputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(OutputField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return TextField(
      controller: _controller,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.end,
      decoration: _payoutFieldDecoration(scheme: scheme, isReadOnly: true, hintText: '0.00'),
    );
  }
}

InputDecoration _payoutFieldDecoration({required ColorScheme scheme, required bool isReadOnly, String? hintText}) {
  Color fill = isReadOnly ? scheme.surface : scheme.primary;
  Color border = isReadOnly ? scheme.onSurface.withValues(alpha: 0.3) : scheme.primary;
  Color text = isReadOnly ? scheme.onSurface : scheme.onPrimary;

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: border,
      width: 1,
      style: BorderStyle.solid,
      strokeAlign: BorderSide.strokeAlignInside,
    ),
  );

  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
    filled: !isReadOnly,
    fillColor: fill,
    counterText: '',
    hintText: hintText,
    hintStyle: TextStyle(color: text),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
  );
}
