import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) { 
        return MaterialApp( 
          debugShowCheckedModeBanner: false,
          title: 'Fixiez',
          theme: AppTheme.appTheme,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: AppRoutes.otpScreen, 
          builder: (context, child) {
            return Directionality(textDirection: TextDirection.rtl, child: child!);
          },
          
        
        );
      },
    );
  }
}
