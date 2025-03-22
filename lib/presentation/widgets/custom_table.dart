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
  });

  final String title;
  final List<String> headers;
  final List<List<String>> data;
  final void Function()? onpressed;
  final double headingRowHeight;
  final double dataRowHeight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 12.w,
                headingRowHeight: headingRowHeight.h,
                dataRowMinHeight: 36.h,
                dataRowMaxHeight: dataRowHeight.h,

                headingTextStyle: AppText.bold12.copyWith(
                  color: AppColors.white,
                ),
                dataTextStyle: AppText.reg10.copyWith(color: AppColors.black),
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xffE6F1FF),
                ),
                border: TableBorder.all(
                  color: const Color(0xFFB9B9B9),
                  width: 1.w,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                columns:
                    headers
                        .map(
                          (e) => DataColumn(
                            label: SizedBox(
                              width: 57.w,
                              child: Center(
                                child: Text(
                                  e,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: AppText.bold12.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                rows:
                    data
                        .map(
                          (e) => DataRow(
                            cells:
                                e
                                    .map(
                                      (e) => DataCell(Center(child: Text(e))),
                                    )
                                    .toList(),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
