import 'package:fixiez/presentation/pages/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  static const initial  = '/';
  static const home = '/home';
  static const login = '/login';
  static const signup = '/Signup';
  static const forgetPassword = '/ForgetPassword';
  static const profile = '/Profile';
  static const code = '/Code';
  static const newPassword = '/NewPassword';
  static const sucessful = '/Sucessful';
  
}

class RouteGenerator {
 static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case AppRoutes.home:
      //   return MaterialPageRoute(builder: (_) => const Home());
      // case AppRoutes.login:
      //   return MaterialPageRoute(builder: (_) => const LOGIN());
      // case AppRoutes.signup:
      //   return MaterialPageRoute(builder: (_) => const Signup());
      // case AppRoutes.forgetPassword:
      //   return MaterialPageRoute(builder: (_) => const ForgetPassword());
      // case AppRoutes.profile:
      //   return MaterialPageRoute(builder: (_) => const Profile());
      // case AppRoutes.code:
      //   return MaterialPageRoute(builder: (_) => const Code());
      // case AppRoutes.newPassword:
      //   return MaterialPageRoute(builder: (_) => const NewPassword());
      // case AppRoutes.sucessful:
      //   return MaterialPageRoute(builder: (_) => const Sucessful());
      default:
        return MaterialPageRoute(builder: (_) => const OnBoarding());

 }  
 }
}