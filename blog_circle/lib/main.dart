import 'package:blog_circle/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:blog_circle/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:blog_circle/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_circle/features/blog/presentation/pages/blog_page.dart';
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
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<BlogBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Circle App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
