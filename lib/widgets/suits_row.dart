import 'package:poker_companion/core/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuitsRowWidget extends StatelessWidget {
  const SuitsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.onSurface;
    final secondary = Theme.of(context).colorScheme.primary;
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final suit in ['club', 'heart', 'spade', 'diamond'])
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: SvgPicture.asset(
                'assets/playing-cards/suits/$suit.svg',
                colorMapper: OutlineMapper(primary, secondary),
              ),
            ),
        ],
      ),
    );
  }
}
