import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottly/Core/Theme/app_pallete.dart';
import 'package:jottly/Core/common/cubits/app_user/app_user_cubit.dart';
import 'package:jottly/Core/common/widgets/loader.dart';
import 'package:jottly/Core/constant/constant.dart';
import 'package:jottly/Core/utils/pick_image.dart';
import 'package:jottly/Core/utils/show_snackbar.dart';
import 'package:jottly/Features/blog/presentation/bloc/blog_bloc.dart';
import 'package:jottly/Features/blog/presentation/pages/home_page.dart';
import 'package:jottly/Features/blog/presentation/widgets/blog_text_field.dart';
// import 'package:jottly/Features/blog/presentation/widgets/category_chips.dart';

class CreateBlogPage extends StatefulWidget {
  const CreateBlogPage({super.key});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> topics = [];
  File? imageFile;

  void selectImage() async {
    final image = await pickImage();
    if (image != null) {
      setState(() {
        imageFile = image;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        topics.isNotEmpty &&
        imageFile != null) {
          print('pranjay1');
      final postedId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
            BlogUpload(
              postedId: postedId,
              title: titleController.text.trim(),
              content: contentController.text.trim(),
              imageUrl: imageFile!,
              topics: topics,
            ),
          );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => uploadBlog(),
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
        if (state is BlogFailure) {
          showSnackbar(context, state.error);
        } else if (state is BlogUploadSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BlogPage(),
            ),
            (route) => false,
          );
        }
      }, builder: (context, state) {
        if(state is BlogLoading){
          return const Loader();
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => selectImage(),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : DottedBorder(
                              radius: Radius.circular(10),
                              strokeWidth: 2,
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              color: AppPallete.borderColor,
                              dashPattern: const [10, 4],
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder,
                                      size: 45,
                                    ),
                                    Text(
                                      'Select your image',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: Constant.topics.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (topics.contains(e)) {
                                topics.remove(e);
                              } else {
                                topics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              color: topics.contains(e)
                                  ? WidgetStatePropertyAll(AppPallete.gradient1)
                                  : null,
                              padding: const EdgeInsets.all(13),
                              label: Text(
                                e,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlogTextField(
                    title: 'Blog Title',
                    textController: titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlogTextField(
                    title: 'Blog Content',
                    textController: contentController,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
