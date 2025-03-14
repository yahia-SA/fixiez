import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(
            ImageAssets.onBoarding,
            width: 328.w,
            height: 328.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 25.h),
          SizedBox(
            width: 375.w,
            height: 65.h,
            child: Center(
              child: Text('أسهل طريقة لتنفيذ طلبك', style: context.bold28Blue),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              'الآن يمكنك العثور على أمهر الصنايعية في منطقتك بكل سهولة اطلب خدمتك ، واستمتع بخدمة سريعة وموثوقة وأمان تام',
              style: context.reg16Hint80,
            ),
          ),
          SizedBox(height: 38.h),
          CustomButton(
            text: 'تسجيل الدخول',
            onpressed: () {
              Navigator.pushNamed(context, AppRoutes.login);
            },
          ),
          SizedBox(height: 24.h),
          CustomButton(
            text: 'انشاء حساب',
            onpressed: () {
              Navigator.pushNamed(context, AppRoutes.signup);
            },
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
