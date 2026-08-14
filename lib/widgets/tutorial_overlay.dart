import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/l10n/app_localizations.dart';

class TutorialStep {
  const TutorialStep({
    required this.targetKey,
    required this.title,
    required this.description,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  final GlobalKey targetKey;
  final String title;
  final String description;
  final BorderRadius borderRadius;
}

/// Shows a full-screen spotlight walkthrough over the widgets referenced by
/// [steps]. Each step's [TutorialStep.targetKey] must already be attached to
/// a rendered widget (i.e. call this after the first frame).
Future<void> showSpotlightTutorial(BuildContext context, List<TutorialStep> steps) {
  if (steps.isEmpty) return Future.value();
  final completer = Completer<void>();
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _SpotlightOverlay(
      steps: steps,
      onFinished: () {
        entry.remove();
        completer.complete();
      },
    ),
  );
  Overlay.of(context, rootOverlay: true).insert(entry);
  return completer.future;
}

class _SpotlightOverlay extends StatefulWidget {
  const _SpotlightOverlay({required this.steps, required this.onFinished});
  final List<TutorialStep> steps;
  final VoidCallback onFinished;

  @override
  State<_SpotlightOverlay> createState() => _SpotlightOverlayState();
}

class _SpotlightOverlayState extends State<_SpotlightOverlay> {
  int _index = 0;

  Rect? get _targetRect {
    final target = widget.steps[_index].targetKey.currentContext;
    if (target == null) return null;
    final box = target.findRenderObject() as RenderBox;
    final topLeft = box.localToGlobal(Offset.zero);
    return topLeft & box.size;
  }

  void _advance() {
    if (_index >= widget.steps.length - 1) {
      widget.onFinished();
    } else {
      setState(() => _index++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[_index];
    final scheme = ThemeController.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final screenSize = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final rect = _targetRect;
    final isLast = _index == widget.steps.length - 1;

    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _advance,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _SpotlightPainter(rect: rect, borderRadius: step.borderRadius, color: scheme.primary),
              ),
            ),
            if (rect != null)
              _TutorialCard(
                targetRect: rect,
                screenSize: screenSize,
                topPadding: padding.top,
                bottomPadding: padding.bottom,
                title: step.title,
                description: step.description,
                scheme: scheme,
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: widget.onFinished,
                      style: TextButton.styleFrom(foregroundColor: scheme.onSurface.withValues(alpha: 0.6)),
                      child: Text(l10n.tutorialSkip),
                    ),
                    Row(
                      children: List.generate(
                        widget.steps.length,
                        (i) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == _index
                                ? scheme.primary
                                : scheme.onSurface.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _advance,
                      style: TextButton.styleFrom(foregroundColor: scheme.primary),
                      child: Text(isLast ? l10n.tutorialGotIt : l10n.tutorialNext),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TutorialCard extends StatelessWidget {
  const _TutorialCard({
    required this.targetRect,
    required this.screenSize,
    required this.topPadding,
    required this.bottomPadding,
    required this.title,
    required this.description,
    required this.scheme,
    required this.trailing,
  });

  final Rect targetRect;
  final Size screenSize;
  final double topPadding;
  final double bottomPadding;
  final String title;
  final String description;
  final ColorScheme scheme;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    const cardMargin = 20.0;
    const gap = 16.0;
    final spaceBelow = screenSize.height - targetRect.bottom - bottomPadding;
    final placeBelow = spaceBelow > 160 || targetRect.top < screenSize.height / 2;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      left: cardMargin,
      right: cardMargin,
      top: placeBelow ? targetRect.bottom + gap : null,
      bottom: placeBelow ? null : (screenSize.height - targetRect.top) + gap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: scheme.onSurface)),
            const SizedBox(height: 6),
            Text(description, style: TextStyle(fontSize: 14, color: scheme.onSurface.withValues(alpha: 0.75))),
            const SizedBox(height: 12),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  _SpotlightPainter({required this.rect, required this.borderRadius, required this.color});
  final Rect? rect;
  final BorderRadius borderRadius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final barrier = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    if (rect == null) {
      canvas.drawPath(barrier, Paint()..color = Colors.black.withValues(alpha: 0.65));
      return;
    }
    final holeRect = rect!.inflate(2);
    final hole = Path()..addRRect(borderRadius.toRRect(holeRect));
    final overlay = Path.combine(PathOperation.difference, barrier, hole);
    canvas.drawPath(overlay, Paint()..color = Colors.black.withValues(alpha: 0.65));
    canvas.drawRRect(
      borderRadius.toRRect(holeRect),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _SpotlightPainter oldDelegate) =>
      oldDelegate.rect != rect || oldDelegate.borderRadius != borderRadius || oldDelegate.color != color;
}
