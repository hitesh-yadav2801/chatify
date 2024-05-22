import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:chatify/chat/domain/repositories/chat_repository.dart';
import 'package:chatify/core/error/failure.dart';
import 'package:chatify/core/usecase/usecase.dart';
import 'package:fpdart/src/either.dart';

class GetMyFriends implements UseCase<List<ChatRoom>, NoParams> {
  final ChatRepository chatRepository;

  GetMyFriends(this.chatRepository);

  @override
  Future<Either<Failure, List<ChatRoom>>> call(NoParams params) async {
    return await chatRepository.getMyFriends();
  }
}
