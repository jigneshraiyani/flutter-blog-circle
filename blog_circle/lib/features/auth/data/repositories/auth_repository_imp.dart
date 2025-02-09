import 'package:blog_circle/core/error/failure.dart';
import 'package:blog_circle/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_circle/features/auth/domain/entities/user.dart';
import 'package:blog_circle/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_circle/core/error/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmail(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
