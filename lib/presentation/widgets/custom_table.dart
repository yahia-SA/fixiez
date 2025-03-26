import 'package:fixiez/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({
    super.key,
    required this.title,
    required this.headers,
    required this.data,
    this.onpressed,
    required this.headingRowHeight,
    required this.dataRowHeight,
    this.headingTextStyle,
    this.headersColor,
    this.titleheight,
    this.columnWidths, this.dataCellStyle, // Optional fixed column widths
  });

  final String title;
  final List<String> headers;
  final List<List<String>> data;
  final void Function()? onpressed;
  final double headingRowHeight;
  final double dataRowHeight;
  final TextStyle? headingTextStyle;
  final TextStyle? dataCellStyle;
  final Color? headersColor;
  final double? titleheight;
  final List<double>? columnWidths; // Fixed widths for each column

  @override
  Widget build(BuildContext context) {
    // Default column widths if not provided
    final defaultColumnWidth = (327.w - (headers.length - 1) * 12.w) / headers.length;
    final effectiveColumnWidths = columnWidths ?? 
        List<double>.filled(headers.length, defaultColumnWidth);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: 327.w, // Fixed table width
        child: Column(
          children: [
            Row(
              children: [
                Text(title, style: context.bold24Blue),
                const Spacer(),
                onpressed != null
                    ? SizedBox(
                        width: 65.w,
                        height: 32.h,
                        child: ElevatedButton(
                          onPressed: onpressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                          ),
                          child: Text('اضافه باقه', style: AppText.med12),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            SizedBox(height: titleheight ?? 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: SizedBox(
                width: effectiveColumnWidths.reduce((a, b) => a + b) + 
                      (headers.length - 1) * 12.w, // Total width of all columns
                child: DataTable(
                  columnSpacing: 1.w,
                  headingRowHeight: headingRowHeight.h,
                  dataRowMinHeight: 36.h,
                  dataRowMaxHeight: dataRowHeight.h,
                  headingTextStyle: headingTextStyle ?? AppText.bold12.copyWith(
                    color: AppColors.white,
                  ),
                  dataTextStyle: AppText.reg10.copyWith(color: AppColors.black),
                  headingRowColor: WidgetStateProperty.all(
                    headersColor ?? const Color(0xffE6F1FF),
                  ),
                  border: TableBorder.all(
                    color: const Color(0xFFB9B9B9),
                    width: 1.w,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  columns: headers.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      return DataColumn(
                        label: SizedBox(
                          width: effectiveColumnWidths[index],
                          child: Center(
                            child: Text(
                              entry.value,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: headingTextStyle ?? AppText.bold12.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  rows: data.map(
                    (row) => DataRow(
                      cells: row.asMap().entries.map(
                        (entry) {
                          final index = entry.key;
                          return DataCell(
                            SizedBox(
                              width: effectiveColumnWidths[index],
                              child: Center(
                                child: Text(
                                  entry.value,
                                  overflow: TextOverflow.ellipsis,
                                  style: dataCellStyle?? AppText.reg12.copyWith(
                                    color: AppColors.black,
                                    height: 1.3.h,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}