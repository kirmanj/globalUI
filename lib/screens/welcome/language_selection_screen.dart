import 'package:flutter/material.dart';
import '../../widgets/section_scaffold.dart';
import '../../theme/app_theme.dart'; // AppPalette, AppGradients, GradientButton

/// Simple model you can feed from config/API.
class LanguageOption {
  final String code; // e.g. 'en', 'ar', 'es'
  final String nativeName; // e.g. 'العربية'
  final String englishName; // e.g. 'Arabic'
  final String countryCode; // for flag (emoji or asset), e.g. 'SA', 'US', 'GB'
  final String? flagAsset; // optional: 'assets/flags/sa.png' (otherwise emoji)
  const LanguageOption({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.countryCode,
    this.flagAsset,
  });
}

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({
    super.key,
    this.languages = _defaultLanguages,
    this.initialSelectedCode,
    this.onContinue,
    this.showContinueButton = true,
    this.title = 'Welcome to Global Sports',
    this.noteText = 'You can change the language later in settings',
  });

  final List<LanguageOption> languages;
  final String? initialSelectedCode;
  final ValueChanged<LanguageOption>? onContinue;
  final bool showContinueButton;
  final String title;
  final String noteText;

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String? _selected;

  // global scale factor (~25% smaller)
  static const double kScale = 0.75;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelectedCode;
  }

  @override
  Widget build(BuildContext context) {
    final selectedOption = widget.languages.firstWhere(
      (l) => l.code == _selected,
      orElse: () => widget.languages.first,
    );

    // shrink all text (including button label & SectionScaffold title) by 25%
    final media = MediaQuery.of(context);
    final scaledMedia = media.copyWith(
      textScaleFactor: media.textScaleFactor * kScale,
    );

    return MediaQuery(
      data: scaledMedia,
      child: SectionScaffold(
        title: widget.title,
        footer:
            widget.showContinueButton
                ? Center(
                  child: GradientButton(
                    label: 'Continue',
                    icon: Icons.arrow_forward_rounded,
                    onPressed:
                        _selected == null
                            ? null
                            : () => widget.onContinue?.call(selectedOption),
                  ),
                )
                : null,
        children: [
          // Brand header banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16 * kScale,
              vertical: 18 * kScale,
            ),
            decoration: const BoxDecoration(
              gradient: AppGradients.primary, // #010669 -> #012DF0
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: const Text(
              'Choose your preferred language',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18, // will be scaled by MediaQuery
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16 * kScale),

          // Responsive grid using percentage widths
          LayoutBuilder(
            builder: (context, constraints) {
              final double maxW = constraints.maxWidth;

              // choose columns by breakpoints (unchanged)
              final int columns =
                  maxW >= 1280
                      ? 4
                      : maxW >= 992
                      ? 3
                      : maxW >= 640
                      ? 2
                      : 1;

              final double gap = 12 * kScale; // spacing between cards (scaled)
              final double totalGapsWidth = gap * (columns - 1);
              final double cardWidth = (maxW - totalGapsWidth) / columns;

              // scale a few visuals based on card width
              final double flagSize =
                  (cardWidth * 0.16).clamp(26.0, 48.0) * kScale; // ~16% of card
              final double vPad =
                  (cardWidth * 0.06).clamp(12.0, 20.0) * kScale; // vertical pad
              final double hPad =
                  (cardWidth * 0.06).clamp(12.0, 20.0) * kScale; // horiz pad
              final double shadowBlur =
                  (cardWidth * 0.06).clamp(10.0, 24.0) * kScale; // shadow

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final lang in widget.languages)
                    SizedBox(
                      width: cardWidth, // percentage-based
                      child: _LanguageCard(
                        option: lang,
                        selected: lang.code == _selected,
                        flagSize: flagSize,
                        verticalPadding: vPad,
                        horizontalPadding: hPad,
                        shadowBlur: shadowBlur,
                        iconScale: kScale,
                        onTap: () {
                          setState(() => _selected = lang.code);
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: AppPalette.gradientEnd,
                                content: Text(
                                  'Language is now ${lang.englishName} (${lang.nativeName})',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                        },
                      ),
                    ),
                ],
              );
            },
          ),

          SizedBox(height: 12 * kScale),
          Text(
            widget.noteText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// A single language card with gradient ring flag + gradient selection border.
class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.option,
    required this.selected,
    required this.onTap,
    required this.flagSize,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.shadowBlur,
    required this.iconScale,
  });

  final LanguageOption option;
  final bool selected;
  final VoidCallback onTap;

  // responsive tuning knobs from parent
  final double flagSize;
  final double verticalPadding;
  final double horizontalPadding;
  final double shadowBlur;
  final double iconScale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(16);

    final bg =
        selected
            ? AppPalette.secondary.withOpacity(
              0.06,
            ) // soft blue fill when selected
            : theme.colorScheme.surface;

    final borderColor =
        selected ? AppPalette.gradientEnd : theme.colorScheme.outlineVariant;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
          boxShadow:
              selected
                  ? [
                    BoxShadow(
                      color: AppPalette.gradientEnd.withOpacity(0.12),
                      blurRadius: shadowBlur,
                      offset: Offset(0, 10 * iconScale),
                    ),
                  ]
                  : null,
        ),
        child: InkWell(
          key: ValueKey('lang-${option.code}'),
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            child: Directionality(
              textDirection:
                  _isRtl(option.code) ? TextDirection.rtl : TextDirection.ltr,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _FlagView(option: option, size: flagSize),
                  SizedBox(width: flagSize * 0.3),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // titleLarge/bodyMedium text will auto-shrink via MediaQuery textScaleFactor
                        Text(
                          option.nativeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          option.englishName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    selected ? 'Selected' : 'Select',
                    style:
                        (selected
                            ? theme.textTheme.bodyMedium?.copyWith(
                              color: AppPalette.gradientEnd,
                              fontWeight: FontWeight.w600,
                            )
                            : theme.textTheme.bodyMedium) ??
                        const TextStyle(),
                  ),
                  SizedBox(width: flagSize * 0.2),

                  Icon(
                    selected
                        ? Icons.check_circle_rounded
                        : Icons.arrow_forward_ios_rounded,
                    size: 24 * iconScale, // icons ~25% smaller
                    color:
                        selected
                            ? AppPalette
                                .tertiary // #01B4FF accent
                            : theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Gradient-ring flag (emoji fallback or asset circle).
class _FlagView extends StatelessWidget {
  const _FlagView({required this.option, required this.size});
  final LanguageOption option;
  final double size;

  @override
  Widget build(BuildContext context) {
    final double ring = (size * 0.06).clamp(1.5, 3.0); // ring thickness

    Widget inner;
    if (option.flagAsset != null && option.flagAsset!.isNotEmpty) {
      inner = ClipOval(
        child: Image.asset(
          option.flagAsset!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _EmojiFlag(option.countryCode, size),
        ),
      );
    } else {
      inner = _EmojiFlag(option.countryCode, size);
    }

    // Gradient ring
    return Container(
      padding: EdgeInsets.all(ring),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppGradients.primary,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: inner,
      ),
    );
  }
}

class _EmojiFlag extends StatelessWidget {
  const _EmojiFlag(this.countryCode, this.size, {super.key});
  final String countryCode;
  final double size;

  @override
  Widget build(BuildContext context) {
    final flag = _emojiFlagFromCountry(countryCode);
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text(
          flag,
          // emoji scale ~70% of circle
          style: TextStyle(fontSize: size * 0.7),
        ),
      ),
    );
  }
}

/// --- Helpers ---------------------------------------------------------------
bool _isRtl(String langCode) {
  const rtl = {'ar', 'fa', 'ur', 'he', 'ps', 'syr'};
  return rtl.contains(langCode.toLowerCase());
}

String _emojiFlagFromCountry(String countryCode) {
  final cc = countryCode.toUpperCase();
  if (cc.length != 2) return '🏳️';
  final base = 0x1F1E6; // regional indicator 'A'
  final a = base + (cc.codeUnitAt(0) - 65);
  final b = base + (cc.codeUnitAt(1) - 65);
  return String.fromCharCodes([a, b]);
}

/// Default list you can replace with your server-provided languages.
const _defaultLanguages = <LanguageOption>[
  LanguageOption(
    code: 'en',
    nativeName: 'English',
    englishName: 'English',
    countryCode: 'US',
  ),
  LanguageOption(
    code: 'es',
    nativeName: 'Español',
    englishName: 'Spanish',
    countryCode: 'ES',
  ),
  LanguageOption(
    code: 'fr',
    nativeName: 'Français',
    englishName: 'French',
    countryCode: 'FR',
  ),
  LanguageOption(
    code: 'de',
    nativeName: 'Deutsch',
    englishName: 'German',
    countryCode: 'DE',
  ),
  LanguageOption(
    code: 'zh',
    nativeName: '中文',
    englishName: 'Chinese',
    countryCode: 'CN',
  ),
  LanguageOption(
    code: 'ar',
    nativeName: 'العربية',
    englishName: 'Arabic',
    countryCode: 'SA',
  ),
  LanguageOption(
    code: 'ja',
    nativeName: '日本語',
    englishName: 'Japanese',
    countryCode: 'JP',
  ),
  LanguageOption(
    code: 'pt',
    nativeName: 'Português',
    englishName: 'Portuguese',
    countryCode: 'PT',
  ),
];
