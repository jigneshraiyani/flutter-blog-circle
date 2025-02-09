import 'package:blog_circle/core/secrets/app_secrets.dart';
import 'package:blog_circle/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_circle/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:blog_circle/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_circle/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:blog_circle/core/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_circle/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_circle/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImp(
              AuthRemoteDataSourceImp(supabase.client),
            ),
          ),
        ),
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
