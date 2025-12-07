import 'package:flutter/material.dart';

class AppColors {
  // Dark Theme Colors (iOS Calculator Style)
  static const Color darkBackground = Color(0xFF000000); // Pure black like iOS
  static const Color darkDisplayArea = Color(0xFF000000);
  static const Color darkKeypadBackground = Color(0xFF000000);

  // Button colors - iOS style
  static const Color darkButtonNumber =
      Color(0xFF333333); // Dark gray for numbers
  static const Color darkButtonFunction =
      Color(0xFFA5A5A5); // Light gray for functions (AC, ±, %)
  static const Color darkButtonOperator =
      Color(0xFFFF9500); // Vibrant orange for operators

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFA5A5A5);
  static const Color darkTextOperator =
      Color(0xFFFFFFFF); // White text on orange

  // Light Theme Colors (iOS Calculator Style)
  static const Color lightBackground = Color(0xFFFFFFFF); // Pure white
  static const Color lightDisplayArea = Color(0xFFFFFFFF);
  static const Color lightKeypadBackground = Color(0xFFFFFFFF);

  // Button colors - iOS light style
  static const Color lightButtonNumber =
      Color(0xFFE0E0E0); // Light gray for numbers
  static const Color lightButtonFunction =
      Color(0xFFD4D4D2); // Slightly darker gray for functions
  static const Color lightButtonOperator =
      Color(0xFFFF9500); // Same vibrant orange

  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF666666);
  static const Color lightTextOperator =
      Color(0xFFFFFFFF); // White text on orange

  // Common
  static const Color operatorOrange = Color(0xFFFF9500); // iOS orange
  static const Color operatorPressed =
      Color(0xFFFFB143); // Lighter orange when pressed
}
