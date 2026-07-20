import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.onChanged,
    this.hintText,
    this.maxLength = 8,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.isReadOnly = false,
  });
  final ValueChanged<String> onChanged;
  final String? hintText;
  final int maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;

    return TextField(
      readOnly: isReadOnly,
      onChanged: onChanged,
      style: TextStyle(color: onPrimary),
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: onPrimary),
        counterText: '',
        filled: true,
        fillColor: primary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(style: BorderStyle.none),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(style: BorderStyle.none),
        ),
      ),
    );
  }
}

class OutputField extends StatelessWidget {
  const OutputField({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    final Color onSurface = Theme.of(context).colorScheme.onSurface;

    return InputDecorator(
      decoration: InputDecoration(
        hintText: '0.00',
        hintStyle: TextStyle(color: onSurface),
        counterText: '',
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: onSurface,
            width: 1,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(style: BorderStyle.none),
        ),
      ),
      child: Text(value),
    );
  }
}
