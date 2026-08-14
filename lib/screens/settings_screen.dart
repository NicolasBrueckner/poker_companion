import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:poker_companion/core/purchases.dart';
import 'package:poker_companion/core/utility.dart';
import 'package:poker_companion/l10n/app_localizations.dart';
import 'package:poker_companion/screens/base_screen.dart';
import 'package:poker_companion/widgets/buttons.dart';
import 'package:poker_companion/widgets/colorswitch.dart';
import 'package:poker_companion/widgets/suits_row.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  int _playerCount = PrefValues.savedPlayerCount;

  late final AnimationController _spadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  late final Animation<double> _spadeScale = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), weight: 60),
  ]).animate(_spadeController);

  ColorScheme? _previousScheme;
  String? _appVersion;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _appVersion = info.version);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scheme = ThemeController.of(context).colorScheme;
    if (_previousScheme != null && _previousScheme != scheme) {
      _spadeController.forward(from: 0);
    }
    _previousScheme = scheme;
  }

  @override
  void dispose() {
    _spadeController.dispose();
    super.dispose();
  }

  void _increment() => setState(() {
    _playerCount++;
    PrefValues.savedPlayerCount = _playerCount;
  });

  void _decrement() {
    if (_playerCount > 1) {
      setState(() {
        _playerCount--;
        PrefValues.savedPlayerCount = _playerCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    return BaseScreen(
      title: l10n.settings,
      actions: [
        for (final suit in ['club', 'heart', 'spade', 'diamond'])
          ScaleTransition(
            scale: _spadeScale,
            child: SvgPicture.asset(
              'assets/playing-cards/suits/$suit.svg',
              width: 32,
              height: 32,
              colorMapper: OutlineMapper(scheme.onSurface, scheme.primary),
            ),
          ),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 28,
          children: [
            _SettingsSection(
              label: l10n.appearanceSection,
              child: _SettingsCard(child: ColorSwitch()),
            ),
            _SettingsSection(
              label: l10n.languageSection,
              child: _SettingsCard(padding: EdgeInsets.zero, child: const _LanguagePicker()),
            ),
            _SettingsSection(
              label: l10n.gameDefaultsSection,
              child: _SettingsCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.defaultPlayerCount,
                        style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface),
                      ),
                    ),
                    _StepButton(icon: Icons.remove, onPressed: _playerCount > 1 ? _decrement : null),
                    Container(
                      width: 36,
                      alignment: Alignment.center,
                      child: Text(
                        '$_playerCount',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: scheme.onSurface),
                      ),
                    ),
                    _StepButton(icon: Icons.add, onPressed: _increment),
                  ],
                ),
              ),
            ),
            _SettingsSection(
              label: l10n.generalSection,
              child: _SettingsCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    const _RemoveAdsRow(),
                    Divider(height: 1, color: scheme.onSurface.withValues(alpha: 0.1)),
                    _SettingsRow(
                      icon: Icons.restore,
                      label: l10n.restorePurchases,
                      onTap: PurchaseService.restore,
                    ),
                    Divider(height: 1, color: scheme.onSurface.withValues(alpha: 0.1)),
                    _SettingsRow(
                      icon: Icons.info_outline,
                      label: l10n.about,
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 10,
                              children: [
                                FractionallySizedBox(widthFactor: 0.75, child: SuitsRowWidget()),
                                Text(
                                  l10n.appTitle,
                                  style: TextStyle(fontWeight: FontWeight.w700, color: scheme.onSurface),
                                ),
                                Text(
                                  l10n.appVersion(_appVersion ?? ''),
                                  style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.55)),
                                ),
                                const _PrivacyPolicyLink(),
                                Text(
                                  l10n.copyrightNotice(DateTime.now().year),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.55)),
                                ),
                                BaseTextButton(label: l10n.close, onPressed: () => Navigator.pop(context)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface.withValues(alpha: 0.55),
              letterSpacing: 0.5,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child, this.padding = const EdgeInsets.all(16)});
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.icon, required this.label, this.trailing, this.onTap});
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: scheme.primary.withValues(alpha: 0.12),
        highlightColor: scheme.primary.withValues(alpha: 0.08),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: scheme.onSurface.withValues(alpha: 0.7)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface),
                ),
              ),
              if (trailing != null) ...[trailing!, const SizedBox(width: 4)],
              Icon(Icons.chevron_right, size: 18, color: scheme.onSurface.withValues(alpha: 0.4)),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = ThemeController.of(context).colorScheme;
    final localeController = LocaleController.of(context);
    final currentCode = localeController.locale?.languageCode;

    final options = <(String?, String)>[
      (null, l10n.systemDefault),
      ('en', 'English'),
      ('de', 'Deutsch'),
      ('es', 'Español'),
      ('fr', 'Français'),
    ];

    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) Divider(height: 1, color: scheme.onSurface.withValues(alpha: 0.1)),
          _LanguageOptionRow(
            label: options[i].$2,
            selected: currentCode == options[i].$1,
            onTap: () => localeController.setLocale(options[i].$1 == null ? null : Locale(options[i].$1!)),
          ),
        ],
      ],
    );
  }
}

class _LanguageOptionRow extends StatelessWidget {
  const _LanguageOptionRow({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: scheme.primary.withValues(alpha: 0.12),
        highlightColor: scheme.primary.withValues(alpha: 0.08),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface)),
              ),
              if (selected) Icon(Icons.check, size: 20, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _RemoveAdsRow extends StatelessWidget {
  const _RemoveAdsRow();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ValueListenableBuilder<bool>(
      valueListenable: PurchaseService.adsRemoved,
      builder: (context, removed, _) {
        if (removed) {
          return _SettingsRow(icon: Icons.check_circle_outline, label: l10n.adsRemoved, onTap: null);
        }
        return ValueListenableBuilder<ProductDetails?>(
          valueListenable: PurchaseService.product,
          builder: (context, product, _) => _SettingsRow(
            icon: Icons.diamond_outlined,
            label: l10n.removeAds,
            trailing: _PricePill(label: product?.price ?? '...'),
            onTap: product == null ? null : PurchaseService.buyRemoveAds,
          ),
        );
      },
    );
  }
}

class _PricePill extends StatelessWidget {
  const _PricePill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: scheme.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: scheme.primary),
      ),
    );
  }
}

class _PrivacyPolicyLink extends StatelessWidget {
  const _PrivacyPolicyLink();

  static final Uri _url = Uri.parse('https://mosscode-studios.com');

  Future<void> _open(BuildContext context) async {
    final launched = await launchUrl(_url, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.couldNotOpenLink)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = ThemeController.of(context).colorScheme;
    return GestureDetector(
      onTap: () => _open(context),
      child: Text(
        AppLocalizations.of(context)!.privacyPolicy,
        style: TextStyle(
          color: scheme.primary,
          fontWeight: FontWeight.w600,
          //decoration: TextDecoration.underline,
          decorationColor: scheme.primary,
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final scheme = ThemeController.of(context).colorScheme;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? scheme.primary : scheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: enabled ? scheme.onPrimary : scheme.onSurface.withValues(alpha: 0.3)),
      ),
    );
  }
}
