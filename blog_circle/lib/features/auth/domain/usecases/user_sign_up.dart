import 'package:blog_circle/core/error/failure.dart';
import 'package:blog_circle/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:blog_circle/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<String, UserSignupParams> {
  final AuthRepository authRepository;

  UserSignUp({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, String>> call(UserSignupParams params) async {
    return await authRepository.signUpWithEmail(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
