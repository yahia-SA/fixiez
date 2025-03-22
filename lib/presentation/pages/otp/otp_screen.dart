import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/bloc/otp/otp_bloc.dart';
import 'package:fixiez/presentation/widgets/cutom_bulidlogo.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, required this.phone});
  final TextEditingController _otpController = TextEditingController();
final String phone;
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
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const BuildLogo(),
            SizedBox(height: 58.h),
            Text('قم بالتحقق من الرسائل النصيه', style: context.bold28Blue),
            SizedBox(height: 8.h),
            Text(
              'لقد أرسلنا رمز التحقق علي رقم الهاتف الخاص بك',
              style: context.reg16Hint92,
            ),
            SizedBox(height: 32.h),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller: _otpController,
                length: 4,
                keyboardType: TextInputType.number,
                focusedPinTheme: PinTheme(
                  width: 67.w,
                  height: 73.h,
                  textStyle: context.med14Black,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                defaultPinTheme: PinTheme(
                  width: 67.w,
                  height: 73.h,
                  textStyle: context.med14Black,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.suffixIconColor),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.h),
            BlocConsumer<OtpBloc, OtpState>(
              listener: (context, state) {
                if (state is OtpSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                    (route) => false,
                  );
                } else if (state is OtpFailure) {
                  UiHelper.showNotification(state.message);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  text: 'تحقق',
                  onpressed: () {
                    context.read<OtpBloc>().add(
                      VerifyOtpEvent(otp: _otpController.text, phone: phone),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
