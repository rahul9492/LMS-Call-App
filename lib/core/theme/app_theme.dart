import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryDark = Color(0xFF1557B0);
  static const Color primaryLight = Color(0xFF4A90D9);
  static const Color accent = Color(0xFF00C853);

  // Surface colors
  static const Color background = Color(0xFF0A0E1A);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceVariant = Color(0xFF1C2534);
  static const Color card = Color(0xFF1A2332);
  static const Color cardHover = Color(0xFF1F2A3D);

  // Call type colors
  static const Color incoming = Color(0xFF00C853);
  static const Color outgoing = Color(0xFF1A73E8);
  static const Color missed = Color(0xFFFF3B30);
  static const Color rejected = Color(0xFFFF9500);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E9BB0);
  static const Color textMuted = Color(0xFF4A5568);
  static const Color textLink = Color(0xFF1A73E8);

  // Status colors
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF1A73E8);

  // Sync status colors
  static const Color syncPending = Color(0xFFFFAB00);
  static const Color syncSynced = Color(0xFF00C853);
  static const Color syncFailed = Color(0xFFFF3B30);

  // Divider / border
  static const Color divider = Color(0xFF1F2A3D);
  static const Color border = Color(0xFF2D3748);
  static const Color borderLight = Color(0xFF374151);
}

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
        surfaceContainerHighest: AppColors.surfaceVariant,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          headlineLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textSecondary),
          bodySmall: TextStyle(color: AppColors.textMuted),
          labelLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          labelMedium: TextStyle(color: AppColors.textSecondary),
          labelSmall: TextStyle(color: AppColors.textMuted),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
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
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        side: const BorderSide(color: AppColors.border, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.card,
        contentTextStyle: const TextStyle(color: AppColors.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.4);
          }
          return AppColors.surfaceVariant;
        }),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
        subtitleTextStyle: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
