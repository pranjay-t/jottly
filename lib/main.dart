import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jottly/Core/Theme/theme.dart';
import 'package:jottly/Features/auth/Presentation/bloc/auth_bloc.dart';
import 'package:jottly/Features/auth/Presentation/pages/sign_up_page.dart';
import 'package:jottly/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsApp.debugAllowBannerOverride = false;
    return MaterialApp(
      title: 'Jottly',
      theme: AppTheme.darkTheme,
      home: SignUpPage(),
    );
  }
}
