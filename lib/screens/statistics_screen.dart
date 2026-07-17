import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatefulWidget> createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Statistics')));
  }
}
