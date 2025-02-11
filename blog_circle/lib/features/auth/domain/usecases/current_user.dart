import 'package:blog_circle/core/error/failure.dart';
import 'package:blog_circle/core/usecase/usecase.dart';
import 'package:blog_circle/core/common/entities/user.dart';
import 'package:blog_circle/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  const CurrentUser({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
