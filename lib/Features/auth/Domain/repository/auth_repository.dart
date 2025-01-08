import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Features/auth/Domain/entities/user.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure,User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}