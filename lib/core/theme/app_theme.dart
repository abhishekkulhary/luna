import 'package:flutter/material.dart';

import 'cycle_colors.dart';
import 'luna_palette.dart';

/// Builds the Material 3 light/dark themes: a moonlit night sky (dark) or a
/// pearly dawn (light), frosted glass surfaces and a rose → lavender accent.
/// Shared [CycleColors] and [LunaPalette] extensions carry the semantic colours.
class AppTheme {
  AppTheme._();

  /// Rose seed color that drives the Material 3 scheme.
  static const seedColor = Color(0xFFE05780);

  /// Bundled font family (declared in pubspec.yaml). No runtime fetching.
  static const fontFamily = 'Manrope';

  static ThemeData light() =>
      _build(Brightness.light, CycleColors.light, LunaPalette.light);
  static ThemeData dark() =>
      _build(Brightness.dark, CycleColors.dark, LunaPalette.dark);

  static ThemeData _build(
    Brightness brightness,
    CycleColors cycleColors,
    LunaPalette luna,
  ) {
    final isDark = brightness == Brightness.dark;
    final scheme =
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: brightness,
        ).copyWith(
          primary: luna.accentStart,
          onPrimary: luna.onAccent,
          secondary: luna.accentEnd,
          onSecondary: luna.onAccent,
          surface: luna.sky,
          onSurface: isDark ? const Color(0xFFF3EEFF) : const Color(0xFF241B35),
          onSurfaceVariant: isDark
              ? const Color(0xFFB4A9CF)
              : const Color(0xFF6B6182),
          outline: isDark ? const Color(0xFF6E6489) : const Color(0xFFB3A8C9),
          outlineVariant: luna.glassBorder,
          // Tonal buttons and containers: lavender / rose washes over the sky.
      primaryContainer:
          Color.alphaBlend(luna.accentStart.withValues(alpha: 0.24), luna.sky),
      onPrimaryContainer:
          isDark ? const Color(0xFFFFE3EE) : const Color(0xFF5A1235),
      secondaryContainer:
          Color.alphaBlend(luna.accentEnd.withValues(alpha: 0.22), luna.sky),
      onSecondaryContainer:
          isDark ? const Color(0xFFEDE5FF) : const Color(0xFF2E1E66),
      surfaceContainerLow: luna.glass,
          surfaceContainer: isDark
              ? const Color(0xFF1B1633)
              : const Color(0xFFF8F2FF),
          surfaceContainerHigh: isDark
              ? const Color(0xFF221C3D)
              : const Color(0xFFF3ECFD),
          surfaceContainerHighest: isDark
              ? const Color(0xFF2A2348)
              : const Color(0xFFEDE4FB),
        );
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      fontFamily: fontFamily,
    );
    final text = base.textTheme.copyWith(
      headlineMedium: base.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
      ),
      headlineSmall: base.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
      titleMedium: base.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
    final sheetColor = isDark
        ? const Color(0xFF16122B)
        : const Color(0xFFFFFBFE);
    final radius16 = BorderRadius.circular(16);

    return base.copyWith(
      scaffoldBackgroundColor: luna.sky,
      textTheme: text,
      extensions: <ThemeExtension<dynamic>>[cycleColors, luna],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.6,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: luna.glass,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: luna.glassBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          // Min height only — do NOT use Size.fromHeight (its width is
          // infinity, which breaks buttons placed in a Row). Opt into
          // full-width with a SizedBox where needed.
          minimumSize: const Size(64, 52),
          backgroundColor: luna.accentStart,
          foregroundColor: luna.onAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: luna.glassBorder),
          backgroundColor: luna.glass,
          shape: RoundedRectangleBorder(borderRadius: radius16),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: luna.accentStart,
        foregroundColor: luna.onAccent,
        elevation: 0,
        shape: const StadiumBorder(),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: luna.glass,
        selectedColor: luna.accentStart.withValues(alpha: isDark ? 0.28 : 0.18),
        checkmarkColor: scheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: radius16),
        side: BorderSide(color: luna.glassBorder),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) =>
              s.contains(WidgetState.selected) ? Colors.white : scheme.outline,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? luna.accentStart
              : luna.glassStrong,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? Colors.transparent
              : luna.glassBorder,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? luna.accentStart.withValues(alpha: isDark ? 0.30 : 0.18)
                : luna.glass,
          ),
          side: WidgetStatePropertyAll(BorderSide(color: luna.glassBorder)),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: luna.glass,
        border: OutlineInputBorder(
          borderRadius: radius16,
          borderSide: BorderSide(color: luna.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius16,
          borderSide: BorderSide(color: luna.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius16,
          borderSide: BorderSide(color: luna.accentStart, width: 1.5),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: luna.accentEnd,
        shape: RoundedRectangleBorder(borderRadius: radius16),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        indicatorColor: luna.accentStart.withValues(
          alpha: isDark ? 0.24 : 0.16,
        ),
        indicatorShape: const StadiumBorder(),
        elevation: 0,
        height: 68,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? luna.accentStart
                : scheme.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            color: states.contains(WidgetState.selected)
                ? scheme.onSurface
                : scheme.onSurfaceVariant,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w800
                : FontWeight.w600,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: sheetColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          side: BorderSide(color: luna.glassBorder),
        ),
        showDragHandle: true,
        dragHandleColor: scheme.outline,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: sheetColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: luna.glassBorder),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: sheetColor,
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: Colors.transparent,
        headerForegroundColor: scheme.onSurface,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? const Color(0xFF2A2348)
            : const Color(0xFF2B2140),
        contentTextStyle: const TextStyle(
          fontFamily: fontFamily,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: radius16),
      ),
      dividerTheme: DividerThemeData(
        color: luna.glassBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
