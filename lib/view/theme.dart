import 'package:flutter/material.dart';

/// Simplified color palette - only essential colors
abstract class AppColors {
  // Brand
  static const Color primary = Color(0xFF1B5E4F); // Deep Forest Green
  static const Color secondary = Color(0xFF7C5CFC); // Purple
  static const Color accentBlue = Color(0xFF4FA8E0); // Sky Blue

  // Status
  static const Color success = Color(0xFF2ECC71); // Green
  static const Color error = Color(0xFFE74C3C); // Red

  // Light mode
  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark mode
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  AppColors._();
}

/// Simple theme configuration
abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accentBlue,
      error: AppColors.error,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightText,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.lightText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: AppColors.lightText, fontSize: 16),
      bodySmall: TextStyle(color: AppColors.lightTextSecondary, fontSize: 12),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accentBlue,
      error: AppColors.error,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.darkText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 16),
      bodySmall: TextStyle(color: AppColors.darkTextSecondary, fontSize: 12),
      labelLarge: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
