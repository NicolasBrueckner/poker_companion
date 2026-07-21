import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, this.child, this.title = ''});
  final Widget? child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: FractionallySizedBox(widthFactor: 0.8, child: child)),
    );
  }
}
