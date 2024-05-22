import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:chatify/chat/domain/repositories/chat_repository.dart';
import 'package:chatify/core/error/failure.dart';
import 'package:chatify/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class CreateChatRoom implements UseCase<ChatRoom, String> {
  final ChatRepository chatRepository;

  CreateChatRoom(this.chatRepository);

  @override
  Future<Either<Failure, ChatRoom>> call(String params) async {
    return await chatRepository.createChatRoom(email: params);
  }

}
