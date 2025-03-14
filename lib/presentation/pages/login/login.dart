import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/blocs/login/login_bloc.dart';
import 'package:fixiez/presentation/blocs/login/login_event.dart';
import 'package:fixiez/presentation/blocs/login/login_state.dart';
import 'package:fixiez/presentation/widgets/custom_formfield.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            var bloc = BlocProvider.of<LoginBloc>(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      ImageAssets.logo,
                      width: 255.w,
                      height: 75.h,
                    ),
                  ),
                  SizedBox(height: 58.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('تسجيل الدخول', style: context.bold28Blue),
                        SizedBox(height: 20.h),
                        Text('رقم الهاتف', style: context.med14Black),
                        SizedBox(height: 12.h),
                        CustomFormfield(
                          controller: _phoneController,
                          hint: 'رقم الهاتف الخاص بك ',
                          type: TextInputType.phone,
                          inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allow only numbers
                  LengthLimitingTextInputFormatter(11), // Prevents input beyond 11 digits
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
                        Text('كلمة المرور', style: context.med14Black),
                        SizedBox(height: 12.h),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return CustomFormfield(
                              controller: _passwordController,
                              hint: 'كلمة المرور',
                              type: TextInputType.text,
                              suffix:
                                  bloc.isPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                              isPassword: !bloc.isPassword,
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
                            TextButton.icon(
                              onPressed: () {},
                              label: Text('تذكرني', style: context.med14Black),
                               icon:  Icon(Icons.check_circle,color: AppColors.suffixIconColor,size: 22.h,),

                            ),
                          ],
                        ),
                        SizedBox(height: 42.h),
                        CustomButton(text: 'تسجيل الدخول', onpressed: () {}),
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
                                style: context.med14Black!.copyWith(decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(context, AppRoutes.signup);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
