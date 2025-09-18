// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

/// --- Brand palette ---------------------------------------------------------
class AppPalette {
  AppPalette._();

  // Core brand
  static const Color gradientStart = Color(0xFF010669);
  static const Color gradientEnd = Color(0xFF012DF0);

  static const Color secondary = Color(0xFF2048F5); // solid brand blue
  static const Color tertiary = Color(0xFF01B4FF); // accent/cyan

  // App chooses white as "primary" (surfaces/background + key elements)
  static const Color primary = Colors.white;

  // Support / neutrals
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF2F4F7);
  static const Color outline = Color(0xFFD0D5DD);
  static const Color textMain = Color(0xFF101828);
  static const Color textMuted = Color(0xFF667085);
}

/// --- Brand gradients -------------------------------------------------------
class AppGradients {
  AppGradients._();

  static const Alignment _begin = Alignment.topLeft;
  static const Alignment _end = Alignment.bottomRight;

  static const LinearGradient primary = LinearGradient(
    colors: [AppPalette.gradientStart, AppPalette.gradientEnd],
    begin: _begin,
    end: _end,
  );

  static const LinearGradient primaryToCyan = LinearGradient(
    colors: [AppPalette.gradientEnd, AppPalette.tertiary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// --- Theme (Material 3) ----------------------------------------------------
class AppTheme {
  AppTheme._();

  static ThemeData light = _buildLight();

  static ThemeData _buildLight() {
    // We keep surfaces/background white, and use brand blues for accents.
    final scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppPalette.primary, // you specified primary = white
      onPrimary: AppPalette.gradientEnd, // readable on white
      secondary: AppPalette.secondary,
      onSecondary: Colors.white,
      tertiary: AppPalette.tertiary,
      onTertiary: Colors.white,
      surface: AppPalette.surface,
      onSurface: AppPalette.textMain,
      surfaceVariant: AppPalette.surfaceVariant,
      onSurfaceVariant: AppPalette.textMuted,
      background: AppPalette.surface,
      onBackground: AppPalette.textMain,
      error: const Color(0xFFB3261E),
      onError: Colors.white,
      outline: AppPalette.outline,
      outlineVariant: const Color(0xFFE4E7EC),
      shadow: Colors.black.withOpacity(0.25),
      scrim: Colors.black54,
      inverseSurface: const Color(0xFF1F2937),
      onInverseSurface: Colors.white,
      inversePrimary: AppPalette.secondary,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppPalette.surface,
      visualDensity: VisualDensity.standard,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppPalette.textMain,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: scheme.surface,
        margin: EdgeInsets.zero,
        elevation: 0.8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: scheme.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppPalette.secondary, width: 1.4),
          borderRadius: BorderRadius.circular(12),
        ),
        hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          backgroundColor: WidgetStateProperty.all<Color>(AppPalette.secondary),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.gradientEnd,
          side: BorderSide(color: scheme.outline),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppPalette.gradientEnd),
      ),

      chipTheme: base.chipTheme.copyWith(
        side: BorderSide(color: scheme.outline),
        selectedColor: AppPalette.secondary.withOpacity(0.12),
        labelStyle: TextStyle(color: scheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
      ),
    );
  }
}

/// --- Handy gradient widgets ------------------------------------------------

/// App bar with your brand gradient.
/// Usage: `appBar: const GradientAppBar(title: Text('Home')),`
class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GradientAppBar({super.key, required this.title, this.actions});
  final Widget title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // keep transparent color; fill with gradient via flexibleSpace
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: AppGradients.primary),
      ),
      title: DefaultTextStyle.merge(
        style: const TextStyle(color: Colors.white),
        child: title,
      ),
      actions: actions,
      foregroundColor: Colors.white,
    );
  }
}

/// A branded gradient button that adapts to disabled/enabled states.
class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final gradient =
        enabled
            ? AppGradients.primary
            : AppGradients.primaryToCyan; // still pretty when disabled

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient, borderRadius: borderRadius),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
