import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/constants/strings.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/service/injection_container.dart';
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
    return BlocProvider
        (create: (context) => sl<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              bool isAdmin = state.user.role == 'admin';
              CacheHelper.saveData(key: 'isAdmin', value: isAdmin);
              Navigator.pushNamedAndRemoveUntil(
                context,
                isAdmin ? AppRoutes.adminpage : AppRoutes.home,
                (route) => false,
              );
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
              UiHelper.showNotification(state.message);
            }
          },
          builder: (context, state) {
            var bloc = context.read<LoginBloc>();
            void submitForm() {
              if (_formKey.currentState!.validate()) {
                TextInput.finishAutofillContext();
                bloc.add(
                  LoginSubmitted(
                    phone: _phoneController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            }
    
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AutofillGroup(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
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
                                  autofillHints: [
                                    AutofillHints.telephoneNumber,
                                    AutofillHints.username,
                                  ],
                                  hint: 'رقم الهاتف الخاص بك',
                                  type: TextInputType.phone,
                                  onEditingComplete:
                                      () => FocusScope.of(context).nextFocus(),
                                  inputFormatters: [
                                    ArabicToEnglishNumberInputFormatter(),
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  validate: validateEgyptianPhoneNumber,),
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
                                      autofillHints: [AutofillHints.password],
                                      hint: 'كلمة المرور',
                                      type: TextInputType.visiblePassword,
                                      onEditingComplete: submitForm,
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
                                      onpressed: submitForm,
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
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
