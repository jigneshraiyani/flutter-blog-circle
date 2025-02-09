import 'package:blog_circle/core/error/failure.dart';
import 'package:blog_circle/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmail({
    required String email,
    required String password,
  });
}
