part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

class BlogInitial extends BlogState {}

class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

class BlogLoading extends BlogState {}

class BlogUploadSuccess extends BlogState {}

class BlogFetchSuccess extends BlogState {
  final List<Blog> blogs;
  BlogFetchSuccess(this.blogs);
}


