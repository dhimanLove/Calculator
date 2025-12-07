import 'package:flutter/material.dart';

abstract class AppThemeColors {
  Color get background;
  Color get displayArea;
  Color get keypadBackground;

  Color get buttonNumber;
  Color get buttonFunction;
  Color get buttonOperator;

  Color get textPrimary;
  Color get textSecondary;
  Color get textOperator;

  // Specific accent colors that might be constant or have a distinct role
  Color get accentOrange;
  Color get accentOrangePressed;
}

class DarkAppThemeColors implements AppThemeColors {
  @override
  Color get background => const Color.fromARGB(255, 0, 0, 0);
  @override
  Color get displayArea => const Color.fromARGB(255, 0, 0, 0);
  @override
  Color get keypadBackground => const Color.fromARGB(255, 27, 27, 27);

  @override
  Color get buttonNumber => const Color.fromARGB(255, 45, 45, 45);
  @override
  Color get buttonFunction => const Color.fromARGB(255, 104, 104, 104);
  @override
  Color get buttonOperator => const Color.fromARGB(255, 255, 149, 0);

  @override
  Color get textPrimary => const Color.fromARGB(255, 255, 255, 255);
  @override
  Color get textSecondary => const Color.fromARGB(255, 180, 180, 180);
  @override
  Color get textOperator => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get accentOrange => const Color.fromARGB(255, 255, 149, 0);
  @override
  Color get accentOrangePressed => const Color.fromARGB(255, 255, 171, 67);
}

class LightAppThemeColors implements AppThemeColors {
  @override
  Color get background => const Color.fromARGB(255, 255, 255, 255);
  @override
  Color get displayArea => const Color.fromARGB(255, 255, 255, 255);
  @override
  Color get keypadBackground => const Color.fromARGB(255, 214, 214, 214);

  @override
  Color get buttonNumber => const Color.fromARGB(255, 255, 255, 255);
  @override
  Color get buttonFunction =>
      const Color.fromARGB(255, 200, 200, 200); // Adjusted for better contrast
  @override
  Color get buttonOperator => const Color.fromARGB(255, 255, 149, 0);

  @override
  Color get textPrimary => const Color.fromARGB(255, 0, 0, 0);
  @override
  Color get textSecondary => const Color.fromARGB(255, 88, 88, 88);
  @override
  Color get textOperator => const Color.fromARGB(255, 0, 0, 0);

  @override
  Color get accentOrange => const Color.fromARGB(255, 255, 149, 0);
  @override
  Color get accentOrangePressed => const Color.fromARGB(255, 255, 171, 67);
}

class AppColors {
  AppColors._(); 

  static AppThemeColors current = DarkAppThemeColors(); 

  static void setTheme(AppThemeColors theme) {
    current = theme;
  }

  // Dark Theme Colors
  static const Color darkBackground = Color.fromARGB(255, 0, 0, 0);
  static const Color darkDisplayArea = Color.fromARGB(255, 0, 0, 0);
  static const Color darkKeypadBackground = Color.fromARGB(255, 27, 27, 27);
  static const Color darkButtonNumber = Color.fromARGB(255, 45, 45, 45);
  static const Color darkButtonFunction = Color.fromARGB(255, 104, 104, 104);
  static const Color darkButtonOperator = Color.fromARGB(255, 255, 149, 0);
  static const Color darkTextPrimary = Color.fromARGB(255, 255, 255, 255);
  static const Color darkTextSecondary = Color.fromARGB(255, 180, 180, 180);
  static const Color darkTextOperator = Color.fromARGB(255, 255, 255, 255);
  static const Color darkAccentOrange = Color.fromARGB(255, 255, 149, 0);
  static const Color darkAccentOrangePressed =
      Color.fromARGB(255, 255, 171, 67);

  // Light Theme Colors
  static const Color lightBackground = Color.fromARGB(255, 255, 255, 255);
  static const Color lightDisplayArea = Color.fromARGB(255, 255, 255, 255);
  static const Color lightKeypadBackground = Color.fromARGB(255, 214, 214, 214);
  static const Color lightButtonNumber = Color.fromARGB(255, 255, 255, 255);
  static const Color lightButtonFunction = Color.fromARGB(255, 200, 200, 200);
  static const Color lightButtonOperator = Color.fromARGB(255, 255, 149, 0);
  static const Color lightTextPrimary = Color.fromARGB(255, 0, 0, 0);
  static const Color lightTextSecondary = Color.fromARGB(255, 88, 88, 88);
  static const Color lightTextOperator = Color.fromARGB(255, 0, 0, 0);
  static const Color lightAccentOrange = Color.fromARGB(255, 255, 149, 0);
  static const Color lightAccentOrangePressed =
      Color.fromARGB(255, 255, 171, 67);
}
