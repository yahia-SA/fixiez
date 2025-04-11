import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/constants/strings.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/service/injection_container.dart';
import 'package:fixiez/presentation/state/bloc/signup/signup_bloc.dart';
import 'package:fixiez/presentation/widgets/custom_formfield.dart';
import 'package:fixiez/presentation/widgets/cutom_bulidlogo.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignupBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BuildLogo(),
                  SizedBox(height: 50.h),
                  BlocConsumer<SignupBloc, SignupState>(
                    listener: (context, state) {
                      if (state is SignupSuccess ||
                          (state is SignupFailure &&
                              state.message ==
                                  'حسابك غير مفعل تحقق من رسالة الجوال الخاصة بك')) {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.otpScreen,
                          arguments: {
                            'phone': _phoneController.text.trim(),
                            'origin': OtpPages.signup,
                          },
                        );
                        if (state is SignupFailure) {
                          UiHelper.showNotification(
                            state.message,
                            backgroundColor: AppColors.yellow,
                          );
                        }
                      } else if (state is SignupFailure) {
                        UiHelper.showNotification(state.message);
                      }
                    },
                    builder: (context, state) {
                      var bloc = BlocProvider.of<SignupBloc>(context);
                      return Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('إنشاء حساب', style: context.bold28Blue),
                            SizedBox(height: 20.h),
                            CustomFormfield(
                              label: 'اسم المستخدم',
                              onEditingComplete:
                                  () => FocusScope.of(context).nextFocus(),
                              controller: _usernameController,
                              hint: 'اسم المستخدم',
                              type: TextInputType.name,
                              autofillHints: [AutofillHints.name],
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomFormfield(
                              label: 'رقم الهاتف',
                              controller: _phoneController,
                              onEditingComplete:
                                  () => FocusScope.of(context).nextFocus(),
                              hint: 'رقم الهاتف الخاص بك',
                              autofillHints: [AutofillHints.telephoneNumber],
                              type: TextInputType.phone,
                              inputFormatters: [
                                ArabicToEnglishNumberInputFormatter(),
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validate: validateEgyptianPhoneNumber,
                            ),
                            SizedBox(height: 20.h),
                            BlocBuilder<SignupBloc, SignupState>(
                              builder: (context, state) {
                                final isPasswordVisible =
                                    (state is ChangePasswordVisibility)
                                        ? state.isVisible
                                        : false;
                                return CustomFormfield(
                                  label: 'انشاء كلمة المرور',
                                  controller: _passwordController,
                                  hint: 'قم بانشاء كلمه مرور الخاصه بك',
                                  type: TextInputType.visiblePassword,
                                  onEditingComplete:
                                      () => FocusScope.of(context).nextFocus(),
                                  suffix:
                                      isPasswordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                  isPassword: !isPasswordVisible,

                                  suffixPressed:
                                      () =>
                                          bloc.add(TogglePasswordVisibility()),
                                  validate: passwordValidator,
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                            BlocBuilder<SignupBloc, SignupState>(
                              builder: (context, state) {
                                final isPasswordVisible =
                                    (state is ChangeConfirmPasswordVisibility)
                                        ? state.isVisible
                                        : false;
                                return CustomFormfield(
                                  label: 'تأكيد كلمة المرور',
                                  controller: _confirmPasswordController,
                                  hint: 'قم بانشاء كلمه مرور الخاصه بك ',
                                  type: TextInputType.visiblePassword,
                                  isPassword: !isPasswordVisible,
                                  suffix:
                                      isPasswordVisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                  suffixPressed:
                                      () => bloc.add(
                                        ToggleConfirmPasswordVisibility(),
                                      ),
                                  onEditingComplete: () {
                                    if (_formKey.currentState!.validate()) {
                                      bloc.add(
                                        SignupSubmitted(
                                          name: _usernameController.text,
                                          phone: _phoneController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 24.h),
                            state is SignupLoading
                                ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                )
                                : CustomButton(
                                  text: 'إنشاء حساب',
                                  onpressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      bloc.add(
                                        SignupSubmitted(
                                          name: _usernameController.text,
                                          phone: _phoneController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                ),
                            SizedBox(height: 24.h),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'هل لديك حساب بالفعل؟',
                                      style: context.reg16Hint80,
                                    ),
                                    TextSpan(
                                      text: 'تسجيل الدخول',
                                      style: context.med14Black!.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.login,
                                              );
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
