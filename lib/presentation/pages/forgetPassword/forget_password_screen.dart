import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/constants/strings.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/service/injection_container.dart';
import 'package:fixiez/presentation/state/bloc/forget_password/forget_password_bloc.dart';
import 'package:fixiez/presentation/widgets/custom_formfield.dart';
import 'package:fixiez/presentation/widgets/cutom_bulidlogo.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgetpasswordBloc>(),
      child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BuildLogo(),
              SizedBox(height: 58.h),
              Text('هل نسيت كلمة المرور ؟', style: context.bold28Blue),
              SizedBox(height: 8.h),
              Text(
                'ادخل رقم الهاتف المرتبط بحسابك',
                style: context.reg16Hint92,
              ),
              SizedBox(height: 32.h),
              CustomFormfield(
                label: 'رقم الهاتف',
                controller: _phoneController,
                autofillHints: [AutofillHints.telephoneNumber],
                hint: 'رقم الهاتف الخاص بك',
                type: TextInputType.phone,
                inputFormatters: [
                  ArabicToEnglishNumberInputFormatter(),
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validate: validateEgyptianPhoneNumber,
              ),
              SizedBox(height: 32.h),
              BlocConsumer<ForgetpasswordBloc, ForgetpasswordState>(
                listener: (context, state) {
                  if (state is ForgetpasswordSuccess) {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.otpScreen,
                      arguments: {
                        'phone': _phoneController.text.trim(),
                        'origin': OtpPages.forgetPassword,
                      },
                    );
                  } else if (state is ForgetpasswordFailure) {
                    UiHelper.showNotification(state.message);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: 'ارسال الرمز',
                    onpressed: () {
                      context.read<ForgetpasswordBloc>().add(
                        SendResetOtpEvent(phone: _phoneController.text),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
