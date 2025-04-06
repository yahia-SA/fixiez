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
    this.titleButtonAction,
    this.titleButton,
    required this.headingRowHeight,
    required this.dataRowHeight,
    this.headingTextStyle,
    this.headersColor,
    this.titleheight,
    this.columnWidths,
    this.dataCellStyle, // Optional fixed column widths
  });

  final String title;
  final String? titleButton;
  final List<String> headers;
  final List<List<Object>> data;
  final void Function()? titleButtonAction;
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
    final defaultColumnWidth = (327.w) / headers.length;
    final effectiveColumnWidths =
        columnWidths ?? List<double>.filled(headers.length, defaultColumnWidth);

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
                titleButton != null
                    ? SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            titleButton!,
                            style: AppText.med16.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.r),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2.w,
                              ),
                            ),
                            child: InkWell(
                              onTap: titleButtonAction,
                              child: Icon(
                                Icons.add,
                                color: AppColors.primary,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox(),
              ],
            ),
            SizedBox(height: titleheight ?? 8.h),
            data.isEmpty
                ? const SizedBox()
                : ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: SizedBox(
                    width:
                        effectiveColumnWidths.reduce((a, b) => a + b) +
                        (headers.length - 1) *
                            12.w, // Total width of all columns
                    child: DataTable(
                      columnSpacing: 1.w,
                      headingRowHeight: headingRowHeight.h,
                      dataRowMinHeight: 36.h,
                      dataRowMaxHeight: dataRowHeight.h,
                      headingTextStyle:
                          headingTextStyle ??
                          AppText.bold12.copyWith(color: AppColors.white),
                      dataTextStyle: AppText.reg10.copyWith(
                        color: AppColors.black,
                      ),
                      headingRowColor: WidgetStateProperty.all(
                        headersColor ?? const Color(0xffE6F1FF),
                      ),
                      border: TableBorder.all(
                        color: const Color(0xFFB9B9B9),
                        width: 1.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      columns:
                          headers.asMap().entries.map((entry) {
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
                                    style:
                                        headingTextStyle ??
                                        AppText.bold12.copyWith(
                                          color: AppColors.primary,
                                        ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                      rows:
                          data
                              .map(
                                (row) => DataRow(
                                  cells:
                                      row.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        return DataCell(
                                          SizedBox(
                                            width: effectiveColumnWidths[index],
                                            child: Center(
                                              child:
                                                  entry.value is String
                                                      ? Text(
                                                        entry.value.toString(),
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style:
                                                            dataCellStyle ??
                                                            AppText.reg12
                                                                .copyWith(
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                  height: 1.3.h,
                                                                ),
                                                      )
                                                      : entry.value is Widget
                                                      ? entry.value as Widget
                                                      : const SizedBox(),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
