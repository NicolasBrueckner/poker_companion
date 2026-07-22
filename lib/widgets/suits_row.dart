import 'package:poker_companion/core/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuitsRowWidget extends StatefulWidget {
  const SuitsRowWidget({super.key});

  @override
  State<SuitsRowWidget> createState() => _SuitsRowWidgetState();
}

class _SuitsRowWidgetState extends State<SuitsRowWidget> {
  late OutlineMapper _mapper;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scheme = ThemeController.of(context).colorScheme;
    _mapper = OutlineMapper(scheme.onSurface, scheme.primary);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final suit in ['club', 'heart', 'spade', 'diamond'])
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: SvgPicture.asset('assets/playing-cards/suits/$suit.svg', colorMapper: _mapper),
            ),
        ],
      ),
    );
  }
}
