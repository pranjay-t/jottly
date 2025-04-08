import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottly/Core/Theme/app_pallete.dart';
import 'package:jottly/Core/common/widgets/loader.dart';
import 'package:jottly/Core/utils/show_snackbar.dart';
import 'package:jottly/Features/blog/presentation/bloc/blog_bloc.dart';
import 'package:jottly/Features/blog/presentation/pages/create_blog_page.dart';
import 'package:jottly/Features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(GetAllBlogsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateBlogPage(),
              ),
            ),
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if(state is BlogFailure){
            showSnackbar(context, state.error);
          }
        },
        builder: (context, state) {
          if(state is BlogLoading){
            return const Loader();
          }
          else if (state is BlogFetchSuccess){
            return ListView.builder(
            itemCount: state.blogs.length,
            itemBuilder: (BuildContext context, int index) {
              final blog = state.blogs[index];
              return  BlogCard(
                  blog: blog,
                  color: index % 2 == 0
                      ? AppPallete.gradient1
                      : AppPallete.gradient2,
                );
            },
          );
          }
          return SizedBox();
        }
      )
    );
  }
}
