import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottly/Core/Theme/app_pallete.dart';
import 'package:jottly/Core/common/widgets/loader.dart';
import 'package:jottly/Core/utils/show_snackbar.dart';
import 'package:jottly/Features/auth/Presentation/bloc/auth_bloc.dart';
import 'package:jottly/Features/auth/Presentation/pages/login_page.dart';
import 'package:jottly/Features/auth/Presentation/widgets/auth_field.dart';
import 'package:jottly/Features/auth/Presentation/widgets/auth_gradient_button.dart';
import 'package:jottly/Features/blog/presentation/pages/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message);
            }
            if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BlogPage()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hintText: 'Name',
                    textEditingController: nameController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    hintText: 'Email',
                    textEditingController: emailController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    hintText: 'Password',
                    textEditingController: passwordController,
                    isObscure: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AuthGradientButton(
                    title: 'Sign Up',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignUp(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage())),
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account? ',
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                fontSize: 17,
                                color: AppPallete.gradient2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
