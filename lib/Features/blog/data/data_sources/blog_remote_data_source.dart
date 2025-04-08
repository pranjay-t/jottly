import 'dart:io';

import 'package:jottly/Core/error/exception.dart';
import 'package:jottly/Features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required BlogModel blog,
    required File imageFile,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImp implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImp(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch(e){
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required BlogModel blog,
    required File imageFile,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            imageFile,
          );

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } on StorageException catch(e){
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<BlogModel>> getAllBlogs()async {
    try {
      final blogs = await supabaseClient.from('blogs').select('*, profiles(name)');
      return blogs.map((blog) =>
        BlogModel.fromJson(blog).copyWith(
          posterName: blog['profiles']['name']
        )
      ).toList();
    } on PostgrestException catch(e){
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
