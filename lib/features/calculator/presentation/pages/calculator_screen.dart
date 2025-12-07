import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';
import '../manager/calculator_controller.dart';
import '../widgets/calculator_button.dart';
import '../widgets/history_drawer.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        final bgColor =
            isDark ? AppColors.darkBackground : AppColors.lightBackground;

        return Scaffold(
          backgroundColor: bgColor,
          endDrawer: const HistoryDrawer(),
          body: SafeArea(
            child: Consumer<CalculatorController>(
              builder: (context, controller, child) {
                return Column(
                  children: [
                    // Top Bar
                    _buildTopBar(context, themeProvider, controller, isDark),

                    // Display Area
                    _buildDisplay(context, controller, isDark),

                    // Keypad Area
                    Expanded(
                      child: _buildKeypad(context, controller, isDark),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context, ThemeProvider themeProvider,
      CalculatorController controller, bool isDark) {
    final iconColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Theme Toggle (Left)
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: iconColor,
              size: 24,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: isDark ? 'Light Mode' : 'Dark Mode',
          ),

          // History Button (Right)
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(
              Icons.history_rounded,
              color: iconColor,
              size: 24,
            ),
            tooltip: 'History',
          ),
        ],
      ),
    );
  }

  Widget _buildDisplay(
      BuildContext context, CalculatorController controller, bool isDark) {
    final displayTextColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final expressionTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Expression
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              controller.userQuestion.isEmpty ? '' : controller.userQuestion,
              style: GoogleFonts.outfit(
                fontSize: 40,
                color: expressionTextColor,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 12),
          // Result
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              controller.userAnswer.isEmpty
                  ? (controller.userQuestion.isEmpty ? '0' : '')
                  : controller.userAnswer,
              style: GoogleFonts.outfit(
                fontSize: 72,
                color: displayTextColor,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypad(
      BuildContext context, CalculatorController controller, bool isDark) {
    // iOS-style 4-column Layout
    final buttons = [
      ['AC', '±', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='], // Special row with 0 spanning 2 columns
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkKeypadBackground
            : AppColors.lightKeypadBackground,
      ),
      child: Column(
        children: buttons.asMap().entries.map((entry) {
          final rowIndex = entry.key;
          final row = entry.value;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: _buildRowButtons(
                  context,
                  row,
                  controller,
                  isDark,
                  isLastRow: rowIndex == buttons.length - 1,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Widget> _buildRowButtons(
    BuildContext context,
    List<String> row,
    CalculatorController controller,
    bool isDark, {
    bool isLastRow = false,
  }) {
    List<Widget> buttons = [];

    for (int i = 0; i < row.length; i++) {
      final buttonText = row[i];

      // Special handling for "0" button - spans 2 columns
      if (buttonText == '0' && isLastRow) {
        buttons.add(
          Expanded(
            flex: 2,
            child: _buildButton(context, buttonText, controller, isDark,
                isWide: true),
          ),
        );
      } else {
        buttons.add(
          Expanded(
            child: _buildButton(context, buttonText, controller, isDark),
          ),
        );
      }
    }

    return buttons;
  }

  Widget _buildButton(
    BuildContext context,
    String buttonText,
    CalculatorController controller,
    bool isDark, {
    bool isWide = false,
  }) {
    Color bgColor;
    Color txtColor;
    double fontSize = 36;

    // Determine colors based on button type - iOS style
    bool isOperator = ['÷', '×', '-', '+', '='].contains(buttonText);
    bool isFunction = ['AC', '±', '%'].contains(buttonText);

    if (isOperator) {
      // Operators get vibrant orange background with white text
      bgColor =
          isDark ? AppColors.darkButtonOperator : AppColors.lightButtonOperator;
      txtColor =
          isDark ? AppColors.darkTextOperator : AppColors.lightTextOperator;
      fontSize = 40; // Slightly larger for operators
    } else if (isFunction) {
      // Functions (AC, ±, %) get light gray background
      bgColor =
          isDark ? AppColors.darkButtonFunction : AppColors.lightButtonFunction;
      txtColor =
          isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
      fontSize = 32;
    } else {
      // Numbers and decimal point get dark gray (dark mode) or light gray (light mode)
      bgColor =
          isDark ? AppColors.darkButtonNumber : AppColors.lightButtonNumber;
      txtColor =
          isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    }

    return CalculatorButton(
      text: buttonText,
      backgroundColor: bgColor,
      textColor: txtColor,
      isCompact: false,
      fontSize: fontSize,
      isWide: isWide,
      onPressed: () {
        controller.onButtonPressed(buttonText);
      },
    );
  }
}
