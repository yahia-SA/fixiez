import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/presentation/pages/admin/admin_page.dart';
import 'package:fixiez/presentation/pages/home/home_page.dart';
import 'package:fixiez/presentation/pages/forgetPassword/forget_password_screen.dart';
import 'package:fixiez/presentation/pages/login/login_screen.dart';
import 'package:fixiez/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:fixiez/presentation/pages/otp/otp_screen.dart';
import 'package:fixiez/presentation/pages/profile/profile_screen.dart';
import 'package:fixiez/presentation/pages/resetPassword/reset_password_screen.dart';
import 'package:fixiez/presentation/pages/settings/setting_page.dart';
import 'package:fixiez/presentation/pages/signup/signup_screen.dart';
import 'package:fixiez/presentation/pages/sucessful/sucessful_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initial = '/';
  static const home = '/home';
  static const login = '/login';
  static const signup = '/Signup';
  static const forgetPassword = '/ForgetPassword';
  static const profile = '/Profile';
  static const otpScreen = '/OtpScreen';
  static const successful = '/successful';
  static const resetPassword = '/ResetPassword';
  static const adminpage = '/AdminPage';
  static const settings = '/Settings';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => Login());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => Signup());
      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPassword());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) =>  ProfileScreen());
      case AppRoutes.otpScreen:
        return MaterialPageRoute(
          builder: (_) {
            final args = settings.arguments as Map<String, dynamic>? ?? {};
            final String phone = args['phone'] ?? '';
            final OtpPages origin =
                args['origin'] ?? 'signup'; // القيمة الافتراضية
            return OtpScreen(phone: phone, origin: origin);
          },
        );
      case AppRoutes.successful:
        return MaterialPageRoute(builder: (_) => const Successful());
      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) {
            final otp = settings.arguments as String? ?? '';
            return Resetpassword(otp: otp);
          },
        );
      case AppRoutes.adminpage:
        return MaterialPageRoute(builder: (_) => const AdminPage());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingPage());
      default:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
    }
  }
}
