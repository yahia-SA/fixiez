// final sl = GetIt.instance; // Service Locator

// void init() {
//   // Bloc
//   sl.registerFactory(() => LoginBloc(loginUseCase: sl()));

//   // UseCase
//   sl.registerLazySingleton(() => LoginUseCase(sl()));

//   // Repository
//   sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()));

//   // Data Source
//   sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
// }
