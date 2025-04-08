import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Core/usecase/usecase.dart';
import 'package:jottly/Features/blog/domain/entities/blog.dart';
import 'package:jottly/Features/blog/domain/repository/blog_repository.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams param) async {
    return await blogRepository.uploadBlog(
      image: param.imageUrl,
      title: param.title,
      content: param.content,
      posterId: param.postedId,
      topics: param.topics,
    );
  }
}

class UploadBlogParams {
  final String postedId;
  final String title;
  final String content;
  final File imageUrl;
  final List<String> topics;

  UploadBlogParams({
    required this.postedId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
  });
}
