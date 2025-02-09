import 'package:blog_circle/core/common/widget/loader.dart';
import 'package:blog_circle/core/theme/app_pallete.dart';
import 'package:blog_circle/core/utils/show_snackbar.dart';
import 'package:blog_circle/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:blog_circle/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:blog_circle/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_circle/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_circle/core/common/widget/loader.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignupPage(),
      );
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double textFormPadding = 15;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign Up.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  SizedBox(
                    height: textFormPadding,
                  ),
                  AuthField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(
                    height: textFormPadding,
                  ),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isSecure: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AuthGradientButton(
                    title: 'Sign Up',
                    onPressed: () {
                      if (formKey.currentState!.validate() == true) {
                        context.read<AuthBloc>().add(AuthSignUp(
                            name: 'name',
                            email: 'email',
                            password: 'password'));
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
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, LoginPage.route());
                      Navigator.push(context, LoginPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an Account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
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
