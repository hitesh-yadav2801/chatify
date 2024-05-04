
import 'package:chatify/auth/domain/repositories/auth_repository.dart';
import 'package:chatify/core/common/entities/user.dart';
import 'package:chatify/core/error/failure.dart';
import 'package:chatify/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
  
}

