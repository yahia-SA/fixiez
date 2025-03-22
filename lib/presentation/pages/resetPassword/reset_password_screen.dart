import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/bloc/resetPassword/reset_password_bloc.dart';
import 'package:fixiez/presentation/widgets/custom_formfield.dart';
import 'package:fixiez/presentation/widgets/cutom_bulidlogo.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Resetpassword extends StatelessWidget {
  Resetpassword({super.key});
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
      child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.successful,
              (route) => false,
            );
          } else if (state is ResetPasswordFailure) {
            UiHelper.showNotification(state.message);
          }
        },
        builder: (context, state) {
          var bloc = context.read<ResetPasswordBloc>();
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const BuildLogo(),
                    SizedBox(height: 58.h),
                    SizedBox(
                      height: 52.h,
                      child: Text(
                        'اعادة تعيين كلمة المرور',
                        style: context.bold28Blue,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 30.h,
                      child: Text(
                        'قم بانشاء كلمه سر جديدة ',
                        style: context.reg16Hint92,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      builder: (context, state) {
                        final isPasswordVisible =
                            (state is ChangePasswordVisibility) &&
                            state.isVisible;
                        return CustomFormfield(
                          label: 'كلمة المرور الجديدة',
                          controller: _passwordController,
                          hint: 'قم باعادة تعيين كلمه مرور خاصه بك ',
                          type: TextInputType.visiblePassword,
                          isPassword: isPasswordVisible,
                          suffix:
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                          suffixPressed: () {
                            bloc.add(TogglePasswordVisibility());
                          },
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
                    SizedBox(height: 32.h),
                    BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      builder: (context, state) {
                        final isPasswordVisible0 =
                            (state is ChangeConfirmPasswordVisibility) &&
                            state.isVisible;
                        return CustomFormfield(
                          label: 'تاكيد كلمة المرور الجديدة',
                          controller: _confirmPasswordController,
                          hint: 'اعد ادخال كلمة المرور',
                          type: TextInputType.visiblePassword,
                          isPassword: isPasswordVisible0,
                          suffix:
                              isPasswordVisible0
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                          suffixPressed: () {
                            bloc.add(ToggleConfirmPasswordVisibility());
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                    state is ResetPasswordLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                          text: 'اعاده تعيين كلمة المرور',
                          onpressed: () {
                            if (_formKey.currentState!.validate()) {
                              // bloc.add(
                              //   ResetpasswordSubmitted(
                              //     password: _passwordController.text,
                              //     confirmPassword: _confirmPasswordController.text,
                              //   ),
                              // );
                            }
                          },
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
