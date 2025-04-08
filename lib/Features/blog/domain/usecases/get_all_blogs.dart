import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Core/usecase/usecase.dart';
import 'package:jottly/Features/blog/domain/entities/blog.dart';
import 'package:jottly/Features/blog/domain/repository/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>,NoParams>{
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(param)async{
    return await blogRepository.getAllBlogs();
  }

}