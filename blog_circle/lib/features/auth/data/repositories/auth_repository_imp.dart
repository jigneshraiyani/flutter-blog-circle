import 'package:blog_circle/core/error/failure.dart';
import 'package:blog_circle/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_circle/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_circle/core/error/server_exception.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await remoteDataSource.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Error, String>> loginWithEmail(
      {required String email, required String password}) {
    // TODO: implement loginWithEmail
    throw UnimplementedError();
  }
}
