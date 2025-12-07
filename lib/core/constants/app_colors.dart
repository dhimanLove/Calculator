import 'package:flutter/material.dart';

class AppColors {
  // Dark Theme Colors (Premium Style)
  static const Color darkBackground = Color(0xFF171717); // Deep dark grey/black
  static const Color darkDisplayArea = Color(0xFF171717);
  static const Color darkKeypadBackground =
      Color(0xFF1C1C1C); // Slightly lighter for keypad area
  static const Color darkButtonBackground =
      Color(0xFF2C2C2C); // Standard button
  static const Color darkButtonFunction = Color(0xFF3A3A3A); // Top rows
  static const Color darkButtonOperator =
      Color(0xFF2C2C2C); // Right column (blends in)
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E8E93);
  static const Color darkAccent =
      Color(0xFF4A4A4A); // For active states or specific highlights

  // Light Theme Colors (Premium Style)
  static const Color lightBackground =
      Color(0xFFF2F2F7); // iOS-like light background
  static const Color lightDisplayArea = Color(0xFFF2F2F7);
  static const Color lightKeypadBackground =
      Color(0xFFFFFFFF); // White keypad background
  static const Color lightButtonBackground =
      Color(0xFFF2F2F7); // Light grey buttons
  static const Color lightButtonFunction =
      Color(0xFFE5E5EA); // Slightly darker for functions
  static const Color lightButtonOperator = Color(0xFFF2F2F7);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF8E8E93);
  static const Color lightAccent =
      Color(0xFF007AFF); // Blue accent if needed, or keep neutral

  // Common
  static const Color operatorTextColor =
      Color(0xFF000000); // Will adjust dynamically
}
