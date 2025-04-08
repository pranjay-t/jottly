import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:jottly/Core/constant/constant.dart';
import 'package:jottly/Core/error/exception.dart';
import 'package:jottly/Core/error/failure.dart';
import 'package:jottly/Core/network/connection_checker.dart';
import 'package:jottly/Features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:jottly/Features/blog/data/local_data_source/blog_local_data_source.dart';
import 'package:jottly/Features/blog/data/model/blog_model.dart';
import 'package:jottly/Features/blog/domain/entities/blog.dart';
import 'package:jottly/Features/blog/domain/repository/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImp(this.blogRemoteDataSource, this.blogLocalDataSource, this.connectionChecker,);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if(! await connectionChecker.isConnected){
        return left(Failure(Constant.noConnectionErrorMessage));
      }
      BlogModel blogModel = BlogModel(
        id: Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        blog: blogModel,
        imageFile: image,
      );

      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );

      final uploadBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async{
   try {
    if(! await connectionChecker.isConnected){
      return right(blogLocalDataSource.loadBlogs());
    }
    final blogs = await blogRemoteDataSource.getAllBlogs();
    blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
     return right(blogs);
   } on ServerException catch (e) {
     return left(Failure(e.message));
   }
  }
}
