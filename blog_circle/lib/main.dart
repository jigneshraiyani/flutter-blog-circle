import 'package:blog_circle/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:blog_circle/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:blog_circle/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_circle/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_circle/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Circle App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
