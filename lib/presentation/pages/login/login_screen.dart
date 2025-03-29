import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/bloc/login/login_bloc.dart';
import 'package:fixiez/presentation/state/bloc/login/login_event.dart';
import 'package:fixiez/presentation/state/bloc/login/login_state.dart';
import 'package:fixiez/presentation/widgets/custom_formfield.dart';
import 'package:fixiez/presentation/widgets/cutom_bulidlogo.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.user.role == 'user') {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.adminpage,
              (route) => false,
            );
          }
        } else if (state is LoginFailure) {
          if (state.message == 'الحساب غير مفعل') {
            Navigator.pushNamed(
              context,
              AppRoutes.otpScreen,
              arguments: {
                'phone': _phoneController.text.trim(),
                'origin': OtpPages.signup,
              },
            );
            return UiHelper.showNotification(
              state.message,
              backgroundColor: AppColors.yellow,
            );
          }
          state.message == 'Invalid credentials'
              ? UiHelper.showNotification('رقم الهاتف او كلمة المرور غير صحيح')
              : UiHelper.showNotification(state.message);
        }
      },
      builder: (context, state) {
        var bloc = BlocProvider.of<LoginBloc>(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BuildLogo(),
                SizedBox(height: 58.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تسجيل الدخول', style: context.bold28Blue),
                      SizedBox(height: 20.h),
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
                      SizedBox(height: 20.h),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          final isPasswordVisible =
                              (state is ChangePasswordVisibility)
                                  ? state.isVisible
                                  : false;
                          return CustomFormfield(
                            label: 'كلمة المرور',
                            controller: _passwordController,
                            hint: 'كلمة المرور',
                            type: TextInputType.visiblePassword,
                            suffix:
                                isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                            isPassword: !isPasswordVisible,
                            suffixPressed:
                                () => bloc.add(TogglePasswordVisibility()),
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.forgetPassword,
                              );
                            },
                            child: Text(
                              'هل نسيت كلمة المرور؟',
                              style: context.med14Black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 42.h),
                      state is LoginLoading
                          ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                          : CustomButton(
                            text: 'تسجيل الدخول',
                            onpressed: () {
                              if (_formKey.currentState!.validate()) {
                                bloc.add(
                                  LoginSubmitted(
                                    phone: _phoneController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              }
                            },
                          ),
                      SizedBox(height: 142.h),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'ليس لديك حساب؟ ',
                                style: context.reg16Hint80,
                              ),
                              TextSpan(
                                text: 'سجل الآن',
                                style: context.med14Black!.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          AppRoutes.signup,
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
