import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:poker_companion/core/root.dart';
import 'package:poker_companion/core/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PrefValues.init();
  MobileAds.instance.initialize();
  runApp(Root());
}
