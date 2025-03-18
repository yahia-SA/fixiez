
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerReviewText extends StatelessWidget {
  const CustomerReviewText({super.key});

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
              hintText: 'من فضلك اكتب تقييمك للخدمه هنا ',
              border: InputBorder.none,
              fillColor: AppColors.white,

              contentPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}
