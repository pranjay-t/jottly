import 'package:flutter/material.dart';
import 'package:jottly/Core/Theme/app_pallete.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isObscure ;
  const AuthField({super.key,required this.hintText,required this.textEditingController, this.isObscure = false});

  @override
  Widget build(BuildContext context) {
     border([color = AppPallete.borderColor]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 3,
            color:color,
          ),
        );
    return TextFormField(
      obscureText: isObscure,
      controller: textEditingController,
      validator: (value) {
        if(value!.isEmpty){
          return '$hintText is missing!';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(25),
        hintText:hintText,
        enabledBorder:border(),
        focusedBorder: border(AppPallete.gradient2),
      ),
    );
  }
}