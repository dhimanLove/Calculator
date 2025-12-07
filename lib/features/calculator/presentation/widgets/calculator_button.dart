import 'package:flutter/material.dart';

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
    final buttonSize = isCompact ? 40.0 : 100.0;
    final buttonRadius = buttonSize / 2;
    final buttonPadding = isCompact ? 8.0 : 12.0;

    return Padding(
      padding: EdgeInsets.all(buttonPadding),
      child: Material(
        color: backgroundColor,
        shape: isWide
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius))
            : const CircleBorder(),
        elevation: 3,
        child: InkWell(
          onTap: onPressed,
          customBorder: isWide
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius))
              : const CircleBorder(),
          splashColor: Colors.white.withValues(alpha: 0.15),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Container(
            height: buttonSize,
            decoration: BoxDecoration(
              shape: isWide ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: isWide ? BorderRadius.circular(buttonRadius) : null,
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
                    style: const TextStyle(
                      fontFamily: 'Chillax',
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                    ).copyWith(
                      color: textColor,
                      fontSize: fontSize ?? (isCompact ? 20 : 32),
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
