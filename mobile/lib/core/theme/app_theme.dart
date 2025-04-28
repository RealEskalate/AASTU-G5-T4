import 'package:flutter/material.dart';

class AppTheme {
  // App Colors
  static const Color primaryColor = Color(0xFF00AB55);
  static const Color secondaryColor = Color(0xFF3366FF);
  static const Color errorColor = Color(0xFFFF4842);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF00B8D9);
  static const Color successColor = Color(0xFF36B37E);

  // Light Theme Colors
  static const Color _lightBackground = Color(0xFFF4F6F8);
  static const Color _lightSurface = Colors.white;
  static const Color _lightError = Color(0xFFB00020);
  static const Color _lightOnPrimary = Colors.white;
  static const Color _lightOnSecondary = Colors.white;
  static const Color _lightOnBackground = Color(0xFF212121);
  static const Color _lightOnSurface = Color(0xFF212121);
  static const Color _lightOnError = Colors.white;

  // Dark Theme Colors
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkError = Color(0xFFCF6679);
  static const Color _darkOnPrimary = Colors.black;
  static const Color _darkOnSecondary = Colors.black;
  static const Color _darkOnBackground = Colors.white;
  static const Color _darkOnSurface = Colors.white;
  static const Color _darkOnError = Colors.black;

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: _lightError,
      background: _lightBackground,
      surface: _lightSurface,
      onPrimary: _lightOnPrimary,
      onSecondary: _lightOnSecondary,
      onBackground: _lightOnBackground,
      onSurface: _lightOnSurface,
      onError: _lightOnError,
    ),
    scaffoldBackgroundColor: _lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: _lightSurface,
      foregroundColor: _lightOnSurface,
      elevation: 1,
    ),
    cardTheme: const CardTheme(
      color: _lightSurface,
      shadowColor: Colors.black,
      elevation: 2,
    ),
    dividerColor: Colors.grey[300],
    iconTheme: const IconThemeData(
      color: Colors.black54,
    ),
    textTheme: _createTextTheme(Colors.black87, Colors.black54),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: _lightOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _lightError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _lightError, width: 2),
      ),
      fillColor: _lightSurface,
      filled: true,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: _darkError,
      background: _darkBackground,
      surface: _darkSurface,
      onPrimary: _darkOnPrimary,
      onSecondary: _darkOnSecondary,
      onBackground: _darkOnBackground,
      onSurface: _darkOnSurface,
      onError: _darkOnError,
    ),
    scaffoldBackgroundColor: _darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: _darkSurface,
      foregroundColor: _darkOnSurface,
      elevation: 0,
    ),
    cardTheme: const CardTheme(
      color: _darkSurface,
      shadowColor: Colors.black,
      elevation: 2,
    ),
    dividerColor: Colors.grey[700],
    iconTheme: IconThemeData(
      color: Colors.grey[400],
    ),
    textTheme: _createTextTheme(Colors.white, Colors.white70),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: _darkOnPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[600]!),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _darkError),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _darkError, width: 2),
      ),
      fillColor: _darkSurface,
      filled: true,
    ),
  );

  // Helper method to create TextTheme
  static TextTheme _createTextTheme(
      Color primaryTextColor, Color secondaryTextColor) {
    return TextTheme(
      displayLarge: TextStyle(color: primaryTextColor),
      displayMedium: TextStyle(color: primaryTextColor),
      displaySmall: TextStyle(color: primaryTextColor),
      headlineLarge: TextStyle(color: primaryTextColor),
      headlineMedium: TextStyle(color: primaryTextColor),
      headlineSmall: TextStyle(color: primaryTextColor),
      titleLarge:
          TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
      titleMedium:
          TextStyle(color: primaryTextColor, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(color: primaryTextColor),
      bodyLarge: TextStyle(color: primaryTextColor),
      bodyMedium: TextStyle(color: primaryTextColor),
      bodySmall: TextStyle(color: secondaryTextColor),
      labelLarge: TextStyle(color: primaryTextColor),
      labelMedium: TextStyle(color: primaryTextColor),
      labelSmall: TextStyle(color: secondaryTextColor),
    );
  }
}
