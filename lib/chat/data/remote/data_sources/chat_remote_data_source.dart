import 'package:chatify/auth/data/remote/models/user_model.dart';
import 'package:chatify/chat/data/remote/models/chat_room_model.dart';
import 'package:chatify/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class ChatRemoteDataSource {
  Session? get currentUserSession;

  Future<ChatRoomModel> createChatRoom({required String email});

  Future<UserModel> getUserModel({required String userId});

  Future<List<ChatRoomModel>> getMyFriends();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SupabaseClient supabaseClient;

  ChatRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<ChatRoomModel> createChatRoom({required String email}) async {
    try {
      final otherUser =
          await supabaseClient.from('users').select().eq('email', email);
      final otherUserModel = UserModel.fromJson(otherUser.first);

      final myUserModel = await getUserModel(userId: currentUserSession!.user.id);
      final chatRoomId = const Uuid().v4();
      final chatRoom = ChatRoomModel(
        [myUserModel, otherUserModel],
        id: chatRoomId,
      );

      await supabaseClient.from('chat_rooms').insert(chatRoom.toJson());

      await supabaseClient.from('chat_room_participants').insert({
        'chat_room_id': chatRoomId,
        'participant_id': currentUserSession!.user.id
      });
      await supabaseClient.from('chat_room_participants').insert({
        'chat_room_id': chatRoomId,
        'participant_id': otherUserModel.id
      });

      return chatRoom;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getUserModel({required String userId}) async {
    try {
      final data = await supabaseClient.from('users').select().eq('id', userId);

      return UserModel.fromJson(data.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ChatRoomModel>> getMyFriends() async {
    try {
      final List<ChatRoomModel> charRooms = [];
      final myUserModel = await getUserModel(userId: currentUserSession!.user.id);
      final responses = await supabaseClient.from('chat_room_participants').select().eq('participant_id', currentUserSession!.user.id);
      print(responses[0]['chat_room_id']);
      for(final response in responses) {
        final res1 = await supabaseClient.from('chat_room_participants').select().eq('chat_room_id', response['chat_room_id']);
        print('here2');
        final otherUserModel = res1[0]['participant_id'] != currentUserSession!.user.id ? await getUserModel(userId: res1[0]['participant_id']) : await getUserModel(userId: res1[1]['participant_id']);
        print('here3');
        final chatRoomModel = ChatRoomModel([myUserModel, otherUserModel], id: response['chat_room_id']);
        charRooms.add(chatRoomModel);
      }
      print(charRooms);

      // final response = await supabaseClient
      //     .from('chat_rooms')
      //     .select()
      //     .eq('participant1_id', currentUserSession!.user.id);
      // final userModel1 =
      //     await getUserModel(userId: currentUserSession!.user.id);
      // final List<ChatRoomModel> charRooms = [];
      //
      // for (final chatRoom in response) {
      //   final userModel2 =
      //       await getUserModel(userId: chatRoom['participant2_id']);
      //
      //   final chatRoomModel = ChatRoomModel.fromJson(chatRoom);
      //
      //   final chatRoomModel2 =
      //       chatRoomModel.copyWith(participants: [userModel1, userModel2]);
      //
      //   charRooms.add(chatRoomModel2);
      // }

      return charRooms;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
