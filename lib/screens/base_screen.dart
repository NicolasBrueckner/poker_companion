import 'package:flutter/material.dart';
import 'package:poker_companion/widgets/bannerad.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, this.child, this.title = '', this.actions});
  final Widget? child;
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis, softWrap: false),
        actions: actions,
        actionsPadding: EdgeInsets.only(right: 20),
      ),
      body: Center(child: FractionallySizedBox(widthFactor: 0.8, child: child)),
      bottomNavigationBar: const CustomBannerAd(),
    );
  }
}
