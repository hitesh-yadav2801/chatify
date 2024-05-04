import 'package:chatify/auth/domain/repositories/auth_repository.dart';
import 'package:chatify/core/common/entities/user.dart';
import 'package:chatify/core/error/failure.dart';
import 'package:chatify/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
