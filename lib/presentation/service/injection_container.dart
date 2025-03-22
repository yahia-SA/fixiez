import 'package:fixiez/data/repositories/repair_repo_impl.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';
import 'package:fixiez/domain/repositories/reapir_repository.dart';
import 'package:fixiez/presentation/state/cubit/repair_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/data/datasources/auth_remote_data_source.dart';
import 'package:fixiez/data/datasources/repair_remote_source.dart';
import 'package:fixiez/data/repositories/auth_repository_impl.dart';
import 'package:fixiez/domain/usecases/login_usecase.dart';
import 'package:fixiez/domain/usecases/signup_usecase.dart';
import 'package:fixiez/presentation/state/bloc/login/login_bloc.dart';
import 'package:fixiez/presentation/state/bloc/signup/signup_bloc.dart';
import 'package:fixiez/presentation/state/bloc/otp/otp_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Register DioHelper
  sl.registerSingleton<DioHelper>(DioHelper.instance);

  // Register Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioHelper>()),
  );
  sl.registerLazySingleton<RepairRemoteDataSource>(
    () => RepairRemoteDataSourceImpl(sl<DioHelper>()),
  );

  // Register Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton<RepairRepository>(
    () => RepairRepositoryImpl(remoteDataSource: sl<RepairRemoteDataSource>()));

  // Register Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignupUseCase(sl<AuthRepository>()));

  // Register BLoCs
  sl.registerFactory(() => LoginBloc(sl<LoginUseCase>()));
  sl.registerFactory(() => SignupBloc(sl<SignupUseCase>()));
  sl.registerFactory(() => OtpBloc(sl<AuthRepository>()));
  sl.registerFactory(() => RepairCubit(sl<RepairRepository>()));
}

