import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isCompact;
  final double? fontSize;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.isCompact = false,
    this.fontSize,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonRadius = isCompact ? 18.0 : 40.0;
    final buttonPadding = isCompact ? 5.0 : 6.0;

    return Padding(
      padding: EdgeInsets.all(buttonPadding),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(buttonRadius),
        elevation: 0,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(buttonRadius),
          splashColor: Colors.white.withValues(alpha: 0.15),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Container(
            height: isCompact ? null : 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            child: Center(
              child: Padding(
                padding: isWide
                    ? const EdgeInsets.only(left: 24.0)
                    : EdgeInsets.zero,
                child: Align(
                  alignment: isWide ? Alignment.centerLeft : Alignment.center,
                  child: Text(
                    text,
                    style: GoogleFonts.outfit(
                      color: textColor,
                      fontSize: fontSize ?? (isCompact ? 22 : 36),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
