import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/constant/constant.dart';
import 'package:jottly/Core/error/exception.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Core/network/connection_checker.dart';
import 'package:jottly/Features/auth/Data/DataSources/auth_remote_data_sources.dart';
import 'package:jottly/Core/common/entities/user.dart';
import 'package:jottly/Features/auth/Data/models/user_model.dart';
import 'package:jottly/Features/auth/Domain/repository/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSources remoteDataSources;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImp(this.remoteDataSources, this.connectionChecker);

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
  }) async {
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
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constant.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSources.currentUserSession;
        if (session == null) {
          return left(Failure('User is not logged In\n Connect to the internet For Sign Up!'));
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSources.getCurrentUserData();
      if (user == null) {
        return left(Failure('user is null'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
