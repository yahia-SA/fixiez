import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerOrderText extends StatelessWidget {
  const CustomerOrderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 326.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey, width: 0.5.w),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: TextField(
            expands: true,
            maxLines: null,
            minLines: null,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: context.reg16Hint80,
            decoration: const InputDecoration(
              hintText: 'اوصف العمل المطلوب',
              border: InputBorder.none,
              fillColor: AppColors.white,
              // Remove any internal padding if necessary
              contentPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}
