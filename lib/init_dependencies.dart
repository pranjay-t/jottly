import 'package:get_it/get_it.dart';
import 'package:jottly/Core/Secret/supabase_secret.dart';
import 'package:jottly/Features/auth/Data/DataSources/auth_remote_data_sources.dart';
import 'package:jottly/Features/auth/Data/repository/auth_repository_imp.dart';
import 'package:jottly/Features/auth/Domain/repository/auth_repository.dart';
import 'package:jottly/Features/auth/Domain/usecases/user_login.dart';
import 'package:jottly/Features/auth/Domain/usecases/user_sign_up.dart';
import 'package:jottly/Features/auth/Presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: SupabaseSecret.supabaseUrl, anonKey: SupabaseSecret.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);
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

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userLogin: serviceLocator(),
      userSignUp: serviceLocator(),
    ),
  );
}
