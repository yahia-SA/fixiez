import 'package:fixiez/data/datasources/admin_remote_data_source.dart';
import 'package:fixiez/data/datasources/balance_remote_data_source.dart';
import 'package:fixiez/data/datasources/banner_remote_data_source.dart';
import 'package:fixiez/data/datasources/review_remote_data_source.dart';
import 'package:fixiez/data/repositories/admin_repository_impl.dart';
import 'package:fixiez/data/repositories/balance_repository_impl.dart';
import 'package:fixiez/data/repositories/banner_repository_impl.dart';
import 'package:fixiez/data/repositories/repair_repo_impl.dart';
import 'package:fixiez/data/repositories/review_repo_impl.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';
import 'package:fixiez/domain/repositories/auth_repository.dart';
import 'package:fixiez/domain/repositories/balance_repository.dart';
import 'package:fixiez/domain/repositories/banner_repository.dart';
import 'package:fixiez/domain/repositories/repair_repository.dart';
import 'package:fixiez/domain/repositories/review_repo.dart';
import 'package:fixiez/domain/usecases/Repair/repair_request.dart';
import 'package:fixiez/domain/usecases/Repair/repair_requests.dart';
import 'package:fixiez/domain/usecases/admin/admin_get_users_usecase.dart';
import 'package:fixiez/domain/usecases/auth/get_balance.dart';
import 'package:fixiez/domain/usecases/auth/reset_password_usecase.dart';
import 'package:fixiez/domain/usecases/auth/send_reset_code_usecase.dart';
import 'package:fixiez/domain/usecases/auth/validate_otp_usecase.dart';
import 'package:fixiez/domain/usecases/banners/banner_usecase.dart';
import 'package:fixiez/domain/usecases/review/review_usecase.dart';
import 'package:fixiez/presentation/state/bloc/forget_password/forget_password_bloc.dart';
import 'package:fixiez/presentation/state/bloc/profile/profile_bloc.dart';
import 'package:fixiez/presentation/state/bloc/resetPassword/reset_password_bloc.dart';
import 'package:fixiez/presentation/state/cubit/banner/banner_cubit.dart';
import 'package:fixiez/presentation/state/cubit/repair_cubit.dart';
import 'package:fixiez/presentation/state/cubit/review/review_cubit.dart';
import 'package:fixiez/presentation/state/cubit/users/users_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/data/datasources/auth_remote_data_source.dart';
import 'package:fixiez/data/datasources/repair_remote_source.dart';
import 'package:fixiez/data/repositories/auth_repository_impl.dart';
import 'package:fixiez/domain/usecases/auth/login_usecase.dart';
import 'package:fixiez/domain/usecases/auth/signup_usecase.dart';
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
  sl.registerLazySingleton<BalanceRemoteDataSource>(
    () => BalanceRemoteDataSourceImpl(sl<DioHelper>()),
  );
  sl.registerLazySingleton<RepairRemoteDataSource>(
    () => RepairRemoteDataSourceImpl(sl<DioHelper>()),
  );
  sl.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(sl<DioHelper>()),
  );

  sl.registerLazySingleton<BannerRemoteDataSource>(
    () => BannerRemoteDataSourceImpl(sl<DioHelper>()),
  );
  sl.registerLazySingleton<AdminRemoteDataSource>(
    () => AdminRemoteDataSourceImpl(sl<DioHelper>()),
  );

  // Register Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton<RepairRepository>(
    () => RepairRepositoryImpl(remoteDataSource: sl<RepairRemoteDataSource>()),
  );
  sl.registerLazySingleton<BalanceRepository>(
    () =>
        BalanceRepositoryImpl(remoteDataSource: sl<BalanceRemoteDataSource>()),
  );
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(remoteDataSource: sl<ReviewRemoteDataSource>()),
  );
  sl.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(remoteDataSource: sl<BannerRemoteDataSource>()),
  );
  sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(remoteDataSource: sl<AdminRemoteDataSource>()),
  );

  // Register Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignupUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SendResetOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ValidateOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetBalanceUseCase(sl<BalanceRepository>()));
  sl.registerLazySingleton(() => RepairRequestsUseCase(sl<RepairRepository>()));
  sl.registerLazySingleton(() => RepairRequestUseCase(sl<RepairRepository>()));
  sl.registerLazySingleton(() => ReviewUsecase(sl<ReviewRepository>()));
  sl.registerLazySingleton(() => BannerUsecase(sl<BannerRepository>()));
  sl.registerLazySingleton(() => GetAdminUsersUseCase(sl<AdminRepository>()));

  // Register BLoCs
  sl.registerFactory(() => LoginBloc(sl<LoginUseCase>()));
  sl.registerFactory(() => SignupBloc(sl<SignupUseCase>()));
  sl.registerFactory(() => OtpBloc(sl<ValidateOtpUseCase>()));
  sl.registerFactory(() => ResetPasswordBloc(sl<ResetPasswordUsecase>()));
  sl.registerFactory(() => ForgetpasswordBloc(sl<SendResetOtpUseCase>()));
  sl.registerFactory(() => RepairCubit(sl<RepairRequestUseCase>()));
  sl.registerFactory(
    () => ProfileBloc(sl<GetBalanceUseCase>(), sl<RepairRequestsUseCase>()),
  );
  sl.registerFactory(() => ReviewCubit(sl<ReviewUsecase>()));
  sl.registerFactory(() => BannerCubit(sl<BannerUsecase>()));
  sl.registerFactory(() => UsersCubit(sl<GetAdminUsersUseCase>()));
}
