import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_companion/core/root.dart';
import 'package:poker_companion/core/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PrefValues.init();
  runApp(Root());
}
