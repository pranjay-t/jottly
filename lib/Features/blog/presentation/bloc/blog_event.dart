part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent{
  final String postedId;
  final String title;
  final String content;
  final File imageUrl;
  final List<String> topics;

  BlogUpload({
    required this.postedId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
  });
}

final class GetAllBlogsEvent extends BlogEvent{
}
