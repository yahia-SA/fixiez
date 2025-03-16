import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.restPassword,
            width: 328.w,
            height: 328.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 17.h),
          SizedBox(
            width: 375.w,
            height: 65.h,
            child: Center(
              child: Text('تم تغيير كلمة المرور بنجاح ', style: context.bold28Blue),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: SizedBox(
              width: 311.w,
              height: 90.h,
              child: Text('لقد تم تغيير كلمة المرور الخاصة بك بنجاح. يمكنك الآن تسجيل الدخول إلى حسابك واستخدام التطبيق بكل أمان.',
                style: context.reg16Hint80!.copyWith(height: 1.5.h),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 38.h),
          CustomButton(
            text: 'العودة الي تسجيل الدخول',
            onpressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }
}