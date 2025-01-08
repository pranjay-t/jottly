import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';

abstract interface class UseCase<SuccessType,Params>{
  Future<Either<Failure,SuccessType>>call(Params param);
}