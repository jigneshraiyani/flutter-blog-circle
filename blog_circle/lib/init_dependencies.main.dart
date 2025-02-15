part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'blogs'),
  );
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );

  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
  serviceLocator.registerFactory(
    () => InternetConnection(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImp(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImp(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Use cases
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImp(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImp(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoriesImp(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
