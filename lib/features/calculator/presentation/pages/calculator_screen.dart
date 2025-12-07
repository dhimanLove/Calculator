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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                fontSize: 32,
                color: expressionTextColor,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 8),
          // Result
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              controller.userAnswer.isEmpty
                  ? (controller.userQuestion.isEmpty ? '0' : '')
                  : controller.userAnswer,
              style: GoogleFonts.outfit(
                fontSize: 56,
                color: displayTextColor,
                fontWeight: FontWeight.w400,
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
    // 5-column Premium Layout
    final buttons = [
      ['MC', 'MR', 'M+', 'M-', 'MS'],
      ['sin', 'cos', 'tan', 'e', '÷'],
      ['ln', 'log', '1/x', '√', '×'],
      ['7', '8', '9', '(', '-'],
      ['4', '5', '6', ')', '+'],
      ['1', '2', '3', '%', '='],
      ['C', '0', '.', '±', '⌫'],
    ];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkKeypadBackground
            : AppColors.lightKeypadBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: buttons.asMap().entries.map((entry) {
          final row = entry.value;
          return Expanded(
            child: Row(
              children: row.map((buttonText) {
                return Expanded(
                  child: _buildButton(context, buttonText, controller, isDark),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String buttonText,
      CalculatorController controller, bool isDark) {
    Color bgColor;
    Color txtColor;
    double fontSize = 24;

    // Determine colors based on type
    bool isOperator = ['÷', '×', '-', '+', '='].contains(buttonText);
    bool isFunction = [
      'C',
      '⌫',
      '±',
      '%',
      '(',
      ')',
      '√',
      '1/x',
      'MC',
      'MR',
      'M+',
      'M-',
      'MS',
      'sin',
      'cos',
      'tan',
      'ln',
      'log',
      'e',
      'π',
      '^',
      '!'
    ].contains(buttonText);

    if (isOperator) {
      bgColor =
          isDark ? AppColors.darkButtonOperator : AppColors.lightButtonOperator;
      txtColor = AppColors.darkAccent; // Use accent color for operators
      if (buttonText == '=') {
        bgColor = AppColors.darkAccent;
        txtColor = Colors.white;
      }
    } else if (isFunction) {
      bgColor =
          isDark ? AppColors.darkButtonFunction : AppColors.lightButtonFunction;
      txtColor =
          isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
      fontSize = 20; // Smaller font for functions
    } else {
      // Numbers
      bgColor = isDark
          ? AppColors.darkButtonBackground
          : AppColors.lightButtonBackground;
      txtColor =
          isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    }

    return CalculatorButton(
      text: buttonText,
      backgroundColor: bgColor,
      textColor: txtColor,
      isCompact: true,
      fontSize: fontSize,
      onPressed: () {
        controller.onButtonPressed(buttonText);
      },
    );
  }
}
