import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../manager/calculator_controller.dart';

class HistoryPanel extends StatelessWidget {
  final bool isDark;

  const HistoryPanel({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorController>(
      builder: (context, controller, child) {
        if (controller.history.isEmpty) {
          return const SizedBox.shrink();
        }

        final displayTextColor =
            isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
        final secondaryTextColor =
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
        final panelBgColor =
            isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: panelBgColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: secondaryTextColor,
                    ),
                    onPressed: () => controller.clearHistory(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...controller.history.take(4).map((item) {
                return InkWell(
                  onTap: () => controller.loadFromHistory(item),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2C2C2E)
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.expression,
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '= ${item.result}',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: displayTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
