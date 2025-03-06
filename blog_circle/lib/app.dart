import 'package:blog_circle/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:blog_circle/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:blog_circle/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:blog_circle/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_circle/features/auth/presentation/pages/login_page.dart';

class App extends StatefulWidget {
  final String title;
  const App({
    super.key,
    required this.title,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
