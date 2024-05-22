import 'package:chatify/chat/data/remote/data_sources/chat_remote_data_source.dart';
import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:chatify/chat/domain/repositories/chat_repository.dart';
import 'package:chatify/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatRepositoryImpl(this.chatRemoteDataSource);
  @override
  Future<Either<Failure, ChatRoom>> createChatRoom({required String email}) async {
    try {
      final chatRoom = await chatRemoteDataSource.createChatRoom(email: email);
      return right(chatRoom);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatRoom>>> getMyFriends() async {
    try {
      final chatRooms = await chatRemoteDataSource.getMyFriends();
      return right(chatRooms);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
