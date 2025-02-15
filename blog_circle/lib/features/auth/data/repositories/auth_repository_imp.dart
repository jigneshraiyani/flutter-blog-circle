import 'package:blog_circle/core/common/network/connection_checker.dart';
import 'package:blog_circle/core/error/failure.dart';
import 'package:blog_circle/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_circle/core/common/entities/user.dart';
import 'package:blog_circle/features/auth/data/models/user_model.dart';
import 'package:blog_circle/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_circle/core/error/server_exception.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImp(
    this.remoteDataSource,
    this.connectionChecker,
  );

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
      if (!await (connectionChecker.isConnected)) {
        return left(
          Failure('No internet connection'),
        );
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentSession;
        if (session == null) {
          return left(
            Failure('User is not logged in!'),
          );
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(
          Failure('User is not logged in!'),
        );
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
