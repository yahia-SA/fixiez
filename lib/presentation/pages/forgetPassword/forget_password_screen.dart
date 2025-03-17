import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/custom_formfield.dart';
import 'package:fixiez/presentation/widgets/cutom_bulidlogo.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox(
        width: 10.67.w,
        height: 18.67.h,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.primary,
              size: 18.67.h,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:  24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const BuildLogo(),
            SizedBox(height: 58.h),
            Text('هل نسيت كلمة المرور ؟', style: context.bold28Blue),
            SizedBox(height: 8.h),
            Text('ادخل رقم الهاتف المرتبط بحسابك', style: context.reg16Hint92),
            SizedBox(height: 32.h),
                        CustomFormfield(
                          label: 'رقم الهاتف',
                          controller: _phoneController,
                          hint: 'رقم الهاتف الخاص بك',
                          type: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length != 11) {
                              return 'Phone number must be 11 digits';
                            }
                            if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
                              return 'Enter a valid Egyptian phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(text: 'ارسال الرمز', onpressed: (){}),
            ],
        ),
      ),
    );
  }
}
