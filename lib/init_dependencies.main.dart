part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.supabaseAnonKey,
  );
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  
  serviceLocator.registerLazySingleton(() => Hive.box('blogs'));


  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImp(internetConnection: serviceLocator()));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImpl(
      serviceLocator(),
    ),
  );
  


  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImp(
      serviceLocator(),
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
      userLogin: serviceLocator(),
      userSignUp: serviceLocator(),
    ),
  );
}

void _initBlog() {
  //DataSource
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
    
  //Repository
      ..registerFactory<BlogRepository>(
        () => BlogRepositoryImp(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ),
      )
  //Usecase
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
  //Bloc
      ..registerLazySingleton(
        () => BlogBloc(
          uploadBlog:  serviceLocator(),
          getAllBlogs: serviceLocator(),
        ),
      );
  }