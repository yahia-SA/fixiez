import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> deleteDialog({required BuildContext context, required String title, required VoidCallback deleteAction, String? buttontext}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: SizedBox(
          width: 317.w,
          height: 223.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.bold24Blue!.copyWith(height: 1.4.h),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 46.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    Container(
                      width: 79.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: TextButton(
                        onPressed: deleteAction,
                        child: Text(
                          buttontext??'حذف',
                          style: context.bold16Blue!.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 79.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: AppColors.primary, width: 0.5.w),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text('إلغاء', style: context.bold16Blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
