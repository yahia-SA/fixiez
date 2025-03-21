import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_theme.dart';
import 'package:fixiez/data/datasources/auth_remote_data_source.dart';
import 'package:fixiez/data/repositories/auth_repository_impl.dart';
import 'package:fixiez/domain/usecases/login_usecase.dart';
import 'package:fixiez/domain/usecases/signup_usecase.dart';
import 'package:fixiez/presentation/blocs/login/login_bloc.dart';
import 'package:fixiez/presentation/blocs/otp/otp_bloc.dart';
import 'package:fixiez/presentation/blocs/signup/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DioHelper.instance.loadTokens();
  await CacheHelper.init();
  final bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  final bool isLoggedIn = CacheHelper.getData(key: 'token') != null;

  final String startRoute =
      onBoarding
          ? (isLoggedIn ? AppRoutes.home : AppRoutes.login)
          : AppRoutes.initial;
  final remoteDataSource = AuthRemoteDataSourceImpl(
    DioHelper.instance,
  ); 
  final authRepository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
  

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authRepository),
        RepositoryProvider(create: (context) => LoginUseCase(authRepository)),
        RepositoryProvider(create: (context)=>SignupUseCase(authRepository)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(context.read<LoginUseCase>()),
          ),
          BlocProvider(
            create: (context) => SignupBloc(context.read<SignupUseCase>()),),
            BlocProvider(create: (context) => OtpBloc(DioHelper.instance,authRepository),),
            
        ],
        child: MyApp(startRoute: startRoute),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startRoute});
  final String? startRoute;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
            initialRoute: startRoute,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
