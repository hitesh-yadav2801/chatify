import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:chatify/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, ChatRoom>> createChatRoom({required String email});

  Future<Either<Failure, List<ChatRoom>>> getMyFriends();
}