import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Primary palette
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFF9D97FF);
  static const primaryDark = Color(0xFF4A42E8);

  // Accent
  static const accent = Color(0xFFFF6584);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFB74D);
  static const error = Color(0xFFEF5350);

  // Streak flame
  static const streakOrange = Color(0xFFFF9800);
  static const streakRed = Color(0xFFF44336);

  // XP
  static const xpGold = Color(0xFFFFD700);
  static const xpRing = Color(0xFF6C63FF);

  // Light theme
  static const lightBg = Color(0xFFF8F9FA);
  static const lightSurface = Colors.white;
  static const lightText = Color(0xFF1A1A2E);
  static const lightSubtext = Color(0xFF6B7280);

  // Dark theme
  static const darkBg = Color(0xFF0F0F23);
  static const darkSurface = Color(0xFF1A1A2E);
  static const darkText = Color(0xFFF8F9FA);
  static const darkSubtext = Color(0xFF9CA3AF);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBg,
      textTheme: GoogleFonts.interTextTheme(),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.lightSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBg,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.lightText,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightSubtext,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBg,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.darkSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBg,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.darkSubtext,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
