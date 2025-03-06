import 'package:blog_circle/app.dart';
import 'package:blog_circle/app_config.dart';
import 'package:blog_circle/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:blog_circle/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:blog_circle/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_circle/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  AppConfig appConfig = AppConfig(
    appName: 'Blog Circel Prod',
    flavor: 'prod',
  );
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
    child: App(
      title: appConfig.flavor,
    ),
  ));
}
