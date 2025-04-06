import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_theme.dart';
import 'package:fixiez/presentation/pages/admin/admin_page.dart';
import 'package:fixiez/presentation/pages/home/home_page.dart';
import 'package:fixiez/presentation/pages/login/login_screen.dart';
import 'package:fixiez/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:fixiez/presentation/service/bloc_providers.dart';
import 'package:fixiez/presentation/service/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DioHelper.instance.loadTokens();
  await CacheHelper.init();
  await init();
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) =>  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(child: Column(
        children: [
          Icon(Icons.error,color: AppColors.error, size: 100.sp),
          Text(errorDetails.summary.toString()),
          Text(errorDetails.exception.toString()),
          const Text('Oops something went wrong'),
        ],
      )),
    ),
  );
  final bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  final bool isAdmin = CacheHelper.getData(key: 'isAdmin') ?? false;
  final bool rememberMe = CacheHelper.getUserField(key: 'AccessToken') != null;
  final String startRoute =
      onBoarding
          ? (rememberMe
              ? (isAdmin ? AppRoutes.adminpage : AppRoutes.home)
              : AppRoutes.login)
          : AppRoutes.initial;

  runApp(MyApp(startRoute: startRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startRoute});
  final String? startRoute;

  @override
  Widget build(BuildContext context) {
    Widget startScreen;

    switch (startRoute) {
      case AppRoutes.home:
        startScreen = const HomePage();
        break;
      case AppRoutes.login:
        startScreen = Login();
        break;
      case AppRoutes.adminpage:
        startScreen = const AdminPage();
        break;
      default:
        startScreen = const OnBoarding();
        break;
    }

    return BlocProvidersList(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return OverlaySupport.global(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Fixiez',
              theme: AppTheme.appTheme,
              onGenerateRoute: RouteGenerator.generateRoute,
              home: startScreen,
              builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
