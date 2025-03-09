import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static const Color orange = Color(0xFFF7931E);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color markerBlack = Color(0xFF262221);

  // Gray scale
  static const Color grey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF727272);
  static const Color darkerGrey = Color(0xFF232120);
  static const Color backgroundGrey = Color(0xFF2B2B2B);

  // Utility colors
  static const Color shadowColor = Color(0x1A000000); // black with 10% opacity

  // Map colors
  static const Color mapBackground = Color(0xFF212121);
  static const Color mapWater = Color(0xFF000000);
  static const Color mapRoad = Color(0xFF2C2C2C);
  static const Color mapRoadArterial = Color(0xFF373737);
  static const Color mapRoadHighway = Color(0xFF3C3C3C);
  static const Color mapRoadControlled = Color(0xFF4E4E4E);
  static const Color mapPark = Color(0xFF181818);
  static const Color mapText = Color(0xFF757575);
  static const Color mapTextSecondary = Color(0xFF616161);
  static const Color mapTextTertiary = Color(0xFF3D3D3D);

  // Background Colors
  static const Color background = Color(0xFFFDF5EC);
  static const Color lightGrey = Color(0xFFF3F4F6);

  // Gradient colors
  static Gradient homeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      orange.withOpacity(0.0001),
      orange.withOpacity(0.0005),
      orange.withOpacity(0.0007),
      orange.withOpacity(0.005),
      orange.withOpacity(0.03),
      orange.withOpacity(0.065),
      white,
    ],
    stops: const [0.0, 0.05, 0.1, 0.4, 0.5, 0.65, 0.9],
  );

  // Text Colors
  static const Color textDark = Color(0xFF232220);
  static const Color textGrey = Color(0xFF6B7280);

  // Base colors
  static const Color backgroundBase = Color(0xFFF7F5F3);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFFA39583);

  // Shadow colors
  static const Color shadowLight = Color(0x0A000000); // 4% opacity
  static const Color shadowMedium = Color(0x0D000000); // 5% opacity

  // Specific UI colors
  static const Color locationIconColor = Color(0xFFA39583);
  static const Color cardBackground = Colors.white;

  // Shadow styles
  static List<BoxShadow> get lightShadow => [
        BoxShadow(
          color: black.withOpacity(0.03),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get locationShadow => [
        BoxShadow(
          color: black.withOpacity(0.04),
          blurRadius: 16,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get mediumShadow => [
        BoxShadow(
          color: black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: orange,
        secondary: grey,
        surface: white,
        onPrimary: white,
        onSecondary: white,
        onSurface: black,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displayMedium: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 14,
          color: textGrey,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: orange, width: 1),
        ),
      ),
    );
  }
}
