import 'package:flutter/material.dart';
import 'package:jottly/Core/Theme/app_pallete.dart';

class BlogTextField extends StatelessWidget {
  final String title;
  final TextEditingController textController;
  const BlogTextField({
    super.key,
    required this.title,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    _border([Color? borderColor]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 2,
          ),
        );
    return TextFormField(
      controller: textController,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$title is missing!';
        }
        return null;
      },
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 15,
        ),
        // filled: true,
        hintText: title,
        border: _border(),
        errorBorder: _border(AppPallete.errorColor),
        enabledBorder: _border(AppPallete.borderColor),
        focusedBorder: _border(AppPallete.gradient2),
      ),
    );
  }
}
