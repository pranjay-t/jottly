import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottly/Core/usecase/usecase.dart';
import 'package:jottly/Features/blog/domain/entities/blog.dart';
import 'package:jottly/Features/blog/domain/usecases/get_all_blogs.dart';
import 'package:jottly/Features/blog/domain/usecases/upload_blog.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  }) : 
  _uploadBlog = uploadBlog,
  _getAllBlogs = getAllBlogs,
  super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<GetAllBlogsEvent>(_onGetAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        postedId: event.postedId,
        title: event.title,
        content: event.content,
        imageUrl: event.imageUrl,
        topics: event.topics,
      ),
    );
    res.fold((l) {
      emit(
        BlogFailure(l.message),
      );
    }, (r) {
      emit(
        BlogUploadSuccess(),
      );
    });
  }

  void _onGetAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());
    res.fold((l) {
      emit(BlogFailure(l.message));
    }, (r) {
      emit(BlogFetchSuccess(r));
    });
  }
}
