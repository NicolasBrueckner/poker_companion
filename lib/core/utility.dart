import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OutlineMapper extends ColorMapper {
  const OutlineMapper(this.black, this.red);
  final Color red;
  final Color black;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    if (color == Color(0xFFFFFFFF)) {
      return red;
    } else if (color == Color(0xFF000000)) {
      return black;
    }
    return color;
  }
}

class ThemeController extends InheritedWidget {
  const ThemeController({
    super.key,
    required this.setTheme,
    required super.child,
  });

  final void Function(String) setTheme;

  static ThemeController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeController>()!;

  @override
  bool updateShouldNotify(ThemeController old) => false;
}
