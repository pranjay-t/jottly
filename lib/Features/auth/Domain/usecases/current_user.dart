import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Core/usecase/usecase.dart';
import 'package:jottly/Core/common/entities/user.dart';
import 'package:jottly/Features/auth/Domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User,NoParams>{
  final AuthRepository authRepository;
  CurrentUser( this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await authRepository.currentUser();
  }

}