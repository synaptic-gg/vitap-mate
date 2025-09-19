import 'package:flutter/material.dart';
import 'package:forui/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vitapmate/core/providers/theme_provider.dart';
import 'package:vitapmate/features/more/presentation/widgets/more_color.dart';
import 'package:vitapmate/src/api/vtop/types.dart';

class MarksTable extends HookConsumerWidget {
  final List<MarksRecordEach> marks;
  const MarksTable({super.key, required this.marks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 2.5,
      ),
      decoration: BoxDecoration(
        color: context.theme.colors.primaryForeground,
        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            color: MarksColors.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              decoration: const BoxDecoration(),
              dividerThickness: darkMode ? 0 : 1,

              headingRowHeight: 56,
              dataRowMinHeight: 48,
              dataRowMaxHeight: 64,
              columnSpacing: 16,
              horizontalMargin: 16,

              columns: [
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "",
                ),
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "Title",
                ),
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "Scored Mark",
                ),
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "Max Marks",
                ),
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "Weightage Mark",
                ),
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "Weightage%",
                ),
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "Status",
                ),
                _buildDataColumn(
                  darkMode
                      ? context.theme.colors.primary
                      : MarksColors.primaryText,
                  "Remark",
                ),
              ],
              rows:
                  marks.asMap().entries.map<DataRow>((entry) {
                    final index = entry.key;
                    final mark = entry.value;
                    final isEven = index % 2 == 0;

                    return DataRow(
                      color: WidgetStateProperty.all(
                        isEven
                            ? Colors.transparent
                            : MarksColors.tableRowAlternate,
                      ),
                      cells: [
                        _buildDataCell(
                          darkMode
                              ? context.theme.colors.primary
                              : MarksColors.primaryText,
                          mark.serial,
                          isNumeric: true,
                        ),
                        _buildDataCell(
                          darkMode
                              ? context.theme.colors.primary
                              : MarksColors.primaryText,
                          mark.markstitle,
                        ),
                        _buildDataCell(
                          darkMode
                              ? context.theme.colors.primary
                              : MarksColors.primaryText,
                          mark.scoredmark,
                          isNumeric: true,
                        ),
                        _buildDataCell(
                          darkMode
                              ? context.theme.colors.primary
                              : MarksColors.primaryText,
                          mark.maxmarks,
                          isNumeric: true,
                        ),
                        _buildDataCell(
                          darkMode
                              ? context.theme.colors.primary
                              : MarksColors.primaryText,
                          mark.weightagemark,
                          isNumeric: true,
                        ),
                        _buildDataCell(
                          darkMode
                              ? context.theme.colors.primary
                              : MarksColors.primaryText,
                          mark.weightage,
                        ),
                        DataCell(_buildStatusBadge(mark.status)),
                        _buildDataCell(
                          darkMode
                              ? context.theme.colors.primary
                              : MarksColors.primaryText,
                          mark.remark,
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  DataColumn _buildDataColumn(Color color, String label) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: color,
        ),
      ),
    );
  }

  DataCell _buildDataCell(Color color, String text, {bool isNumeric = false}) {
    return DataCell(
      Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isNumeric ? FontWeight.w600 : FontWeight.w400,
          color: color,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final statusLower = status.toLowerCase();

    Color backgroundColor;
    Color textColor;
    Color borderColor;
    IconData icon;

    if (statusLower.contains('pass') || statusLower.contains('complete')) {
      backgroundColor = MarksColors.passedBackground;
      textColor = MarksColors.passedText;
      borderColor = MarksColors.passedBorder;
      icon = Icons.check_circle_outline;
    } else if (statusLower.contains('fail')) {
      backgroundColor = MarksColors.failedBackground;
      textColor = MarksColors.failedText;
      borderColor = MarksColors.failedBorder;
      icon = Icons.cancel_outlined;
    } else {
      backgroundColor = MarksColors.pendingBackground;
      textColor = MarksColors.pendingText;
      borderColor = MarksColors.pendingBorder;
      icon = Icons.schedule_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
