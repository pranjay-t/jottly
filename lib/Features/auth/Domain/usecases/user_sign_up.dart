import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Core/usecase/usecase.dart';
import 'package:jottly/Features/auth/Domain/entities/user.dart';
import 'package:jottly/Features/auth/Domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRespository;
  UserSignUp(this.authRespository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams param) async {
    return await authRespository.signUpWithEmailPassword(
      name: param.name,
      email: param.email,
      password: param.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
