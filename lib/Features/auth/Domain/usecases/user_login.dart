import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Core/usecase/usecase.dart';
import 'package:jottly/Features/auth/Domain/repository/auth_repository.dart';
import 'package:jottly/Core/common/entities/user.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin( this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams param) {
    return authRepository.loginWithEmailPassword(
      email: param.email,
      password: param.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
