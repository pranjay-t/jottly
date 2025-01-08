import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/exception.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Features/auth/Data/DataSources/auth_remote_data_sources.dart';
import 'package:jottly/Features/auth/Domain/entities/user.dart';
import 'package:jottly/Features/auth/Domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSources remoteDataSources;
  AuthRepositoryImp(this.remoteDataSources);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(
      () async => await remoteDataSources.signInWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  })async {
    return _getUser(
      () async => await remoteDataSources.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    }on sb.AuthException catch (e) {
      return left(Failure(e.toString()));
    }
    on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
