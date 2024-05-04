part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  //Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;


  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
        () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  // We can also define type of the serviceLocator in the AuthRemoteDataSourceImpl but Get_It automatically does that for us
  // AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()), we can do like this also

  // This is Data Source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
  // This is repository
    ..registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
  // This is use case
    ..registerFactory(
          () => UserSignUp(
        serviceLocator(),
      ),
    )
  // This is use case
    ..registerFactory(
          () => UserLogin(
        serviceLocator(),
      ),
    )
  // This is use case
    ..registerFactory(
          () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
          () => UserSignOut(
        serviceLocator(),
      ),
    )
  // This is Bloc
    ..registerLazySingleton(
          () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userSignOut: serviceLocator(),
      ),
    );
}