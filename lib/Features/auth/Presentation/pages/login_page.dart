import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottly/Core/Theme/app_pallete.dart';
import 'package:jottly/Core/common/widgets/loader.dart';
import 'package:jottly/Core/utils/show_snackbar.dart';
import 'package:jottly/Features/auth/Presentation/bloc/auth_bloc.dart';
import 'package:jottly/Features/auth/Presentation/pages/sign_up_page.dart';
import 'package:jottly/Features/auth/Presentation/widgets/auth_field.dart';
import 'package:jottly/Features/auth/Presentation/widgets/auth_gradient_button.dart';
import 'package:jottly/Features/blog/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
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
            if(state is AuthFailure){
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
            if(state is AuthLoading){
              return Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
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
                    title: 'Sign In',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
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
                        MaterialPageRoute(builder: (context) => SignUpPage())),
                    child: RichText(
                      text:
                          TextSpan(text: 'Don\'t have an account? ', children: [
                        TextSpan(
                          text: 'Sign Up',
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
