import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Fixed brand / semantic colors (same in both modes) ────────────────────────

class AppColors {
  AppColors._();

  // Primary brand
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF1557B0);
  static const Color primaryLight = Color(0xFF4A90D9);
  static const Color accent = Color(0xFF00C853);

  // Call type colors (always the same)
  static const Color incoming = Color(0xFF00C853);
  static const Color outgoing = Color(0xFF1A73E8);
  static const Color missed = Color(0xFFFF3B30);
  static const Color rejected = Color(0xFFFF9500);

  // Semantic
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF1A73E8);

  // Sync status
  static const Color syncPending = Color(0xFFFFAB00);
  static const Color syncSynced = Color(0xFF00C853);
  static const Color syncFailed = Color(0xFFFF3B30);

  // ── Dark mode surfaces ───────────────────────────────────────────────────
  static const Color darkBackground    = Color(0xFF0A0E1A);
  static const Color darkSurface       = Color(0xFF111827);
  static const Color darkSurfaceVariant= Color(0xFF1C2534);
  static const Color darkCard          = Color(0xFF1A2332);
  static const Color darkCardHover     = Color(0xFF1F2A3D);
  static const Color darkTextPrimary   = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E9BB0);
  static const Color darkTextMuted     = Color(0xFF4A5568);
  static const Color darkDivider       = Color(0xFF1F2A3D);
  static const Color darkBorder        = Color(0xFF2D3748);
  static const Color darkBorderLight   = Color(0xFF374151);

  // ── Light mode surfaces ──────────────────────────────────────────────────
  static const Color lightBackground    = Color(0xFFFFFFFF);
  static const Color lightSurface       = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant= Color(0xFFF2F4F8);
  static const Color lightCard          = Color(0xFFFFFFFF);
  static const Color lightCardHover     = Color(0xFFF5F7FA);
  static const Color lightTextPrimary   = Color(0xFF0D1117);
  static const Color lightTextSecondary = Color(0xFF4A5568);
  static const Color lightTextMuted     = Color(0xFF9AA5B4);
  static const Color lightDivider       = Color(0xFFE2E8F0);
  static const Color lightBorder        = Color(0xFFCBD5E0);
  static const Color lightBorderLight   = Color(0xFFE2E8F0);
}

// ── Theme-aware color extension on BuildContext ───────────────────────────────
//
// Usage:  context.colors.background   (reads dark or light automatically)

extension AppColorsX on BuildContext {
  AppColorSet get colors {
    final dark = Theme.of(this).brightness == Brightness.dark;
    return dark ? const _DarkColors() : const _LightColors();
  }
}

abstract class AppColorSet {
  const AppColorSet();
  Color get background;
  Color get surface;
  Color get surfaceVariant;
  Color get card;
  Color get cardHover;
  Color get textPrimary;
  Color get textSecondary;
  Color get textMuted;
  Color get divider;
  Color get border;
  Color get borderLight;
}

class _DarkColors extends AppColorSet {
  const _DarkColors();
  @override Color get background     => AppColors.darkBackground;
  @override Color get surface        => AppColors.darkSurface;
  @override Color get surfaceVariant => AppColors.darkSurfaceVariant;
  @override Color get card           => AppColors.darkCard;
  @override Color get cardHover      => AppColors.darkCardHover;
  @override Color get textPrimary    => AppColors.darkTextPrimary;
  @override Color get textSecondary  => AppColors.darkTextSecondary;
  @override Color get textMuted      => AppColors.darkTextMuted;
  @override Color get divider        => AppColors.darkDivider;
  @override Color get border         => AppColors.darkBorder;
  @override Color get borderLight    => AppColors.darkBorderLight;
}

class _LightColors extends AppColorSet {
  const _LightColors();
  @override Color get background     => AppColors.lightBackground;
  @override Color get surface        => AppColors.lightSurface;
  @override Color get surfaceVariant => AppColors.lightSurfaceVariant;
  @override Color get card           => AppColors.lightCard;
  @override Color get cardHover      => AppColors.lightCardHover;
  @override Color get textPrimary    => AppColors.lightTextPrimary;
  @override Color get textSecondary  => AppColors.lightTextSecondary;
  @override Color get textMuted      => AppColors.lightTextMuted;
  @override Color get divider        => AppColors.lightDivider;
  @override Color get border         => AppColors.lightBorder;
  @override Color get borderLight    => AppColors.lightBorderLight;
}

// ── Theme data ────────────────────────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);
  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final bg           = isDark ? AppColors.darkBackground     : AppColors.lightBackground;
    final surface      = isDark ? AppColors.darkSurface        : AppColors.lightSurface;
    final surfaceVar   = isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant;
    final cardColor    = isDark ? AppColors.darkCard           : AppColors.lightCard;
    final textPrimary  = isDark ? AppColors.darkTextPrimary    : AppColors.lightTextPrimary;
    final textSecondary= isDark ? AppColors.darkTextSecondary  : AppColors.lightTextSecondary;
    final textMuted    = isDark ? AppColors.darkTextMuted      : AppColors.lightTextMuted;
    final divider      = isDark ? AppColors.darkDivider        : AppColors.lightDivider;
    final border       = isDark ? AppColors.darkBorder         : AppColors.lightBorder;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
        onError: Colors.white,
        surfaceContainerHighest: surfaceVar,
      ),
      scaffoldBackgroundColor: bg,
      textTheme: GoogleFonts.interTextTheme(
        TextTheme(
          displayLarge:  TextStyle(color: textPrimary,   fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: textPrimary,   fontWeight: FontWeight.bold),
          displaySmall:  TextStyle(color: textPrimary,   fontWeight: FontWeight.w600),
          headlineLarge: TextStyle(color: textPrimary,   fontWeight: FontWeight.bold),
          headlineMedium:TextStyle(color: textPrimary,   fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: textPrimary,   fontWeight: FontWeight.w600),
          titleLarge:    TextStyle(color: textPrimary,   fontWeight: FontWeight.w600),
          titleMedium:   TextStyle(color: textPrimary,   fontWeight: FontWeight.w500),
          titleSmall:    TextStyle(color: textPrimary,   fontWeight: FontWeight.w500),
          bodyLarge:     TextStyle(color: textPrimary),
          bodyMedium:    TextStyle(color: textSecondary),
          bodySmall:     TextStyle(color: textMuted),
          labelLarge:    TextStyle(color: textPrimary,   fontWeight: FontWeight.w600),
          labelMedium:   TextStyle(color: textSecondary),
          labelSmall:    TextStyle(color: textMuted),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: DividerThemeData(color: divider, thickness: 0.5),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: BorderSide(color: border),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVar,
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        labelStyle: TextStyle(color: textSecondary),
        side: BorderSide(color: border, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVar,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: TextStyle(color: textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardColor,
        contentTextStyle: TextStyle(color: textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.4);
          }
          return surfaceVar;
        }),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: textSecondary,
        textColor: textPrimary,
        subtitleTextStyle: TextStyle(color: textSecondary),
      ),
    );
  }
}
