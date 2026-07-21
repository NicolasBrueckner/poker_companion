import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.isReadOnly = false,
    required this.onChanged,
    this.maxLength = 8,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.hintText,
  });
  final bool isReadOnly;
  final ValueChanged<String> onChanged;
  final int maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
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

class OutputField extends StatelessWidget {
  const OutputField({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(value),
      initialValue: value,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.end,
      decoration: _payoutFieldDecoration(scheme: Theme.of(context).colorScheme, isReadOnly: true, hintText: '0.00'),
    );
  }
}

InputDecoration _payoutFieldDecoration({required ColorScheme scheme, required bool isReadOnly, String? hintText}) {
  Color fill = isReadOnly ? scheme.surface : scheme.primary;
  Color border = isReadOnly ? scheme.onSurface : scheme.primary;
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
