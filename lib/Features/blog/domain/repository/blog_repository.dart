import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Features/blog/domain/entities/blog.dart';

abstract class BlogRepository {
  Future<Either<Failure,Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure,List<Blog>>> getAllBlogs();
}