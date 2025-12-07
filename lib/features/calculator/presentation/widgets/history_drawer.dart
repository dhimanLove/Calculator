import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/theme_provider.dart';
import '../manager/calculator_controller.dart';

class HistoryDrawer extends StatelessWidget {
  const HistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        final bgColor =
            isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF5F5F7);
        final displayTextColor =
            isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
        final secondaryTextColor =
            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

        return Drawer(
          backgroundColor: bgColor,
          width: MediaQuery.of(context).size.width * 0.85,
          child: SafeArea(
            child: Consumer<CalculatorController>(
              builder: (context, controller, child) {
                return Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'History',
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              color: displayTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: displayTextColor,
                              size: 24,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    // History List
                    Expanded(
                      child: controller.history.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 64,
                                    color: secondaryTextColor.withValues(
                                        alpha: 0.3),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No history yet',
                                    style: GoogleFonts.outfit(
                                      fontSize: 18,
                                      color: secondaryTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Your calculations will appear here',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                      color: secondaryTextColor.withValues(
                                          alpha: 0.7),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: controller.history.length,
                              itemBuilder: (context, index) {
                                final item = controller.history[index];
                                return _buildHistoryItem(
                                  context,
                                  item.expression,
                                  item.result,
                                  isDark,
                                  displayTextColor,
                                  secondaryTextColor,
                                  () {
                                    controller.loadFromHistory(item);
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                    ),

                    // Clear History Button
                    if (controller.history.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              controller.clearHistory();
                            },
                            icon: const Icon(Icons.delete_outline),
                            label: Text(
                              'Clear History',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? const Color(0xFF2C2C2E)
                                  : const Color(0xFFE5E5EA),
                              foregroundColor: isDark
                                  ? Colors.red.shade400
                                  : Colors.red.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
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

  Widget _buildHistoryItem(
    BuildContext context,
    String expression,
    String result,
    bool isDark,
    Color displayTextColor,
    Color secondaryTextColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expression,
              style: GoogleFonts.outfit(
                fontSize: 18,
                color: secondaryTextColor,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '= ',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    color: displayTextColor.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Expanded(
                  child: Text(
                    result,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      color: displayTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
