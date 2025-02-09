import 'package:blog_circle/core/error/failure.dart';
import 'package:blog_circle/core/usecase/usecase.dart';
import 'package:blog_circle/features/auth/domain/entities/user.dart';
import 'package:blog_circle/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
