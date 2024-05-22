part of 'chat_room_bloc.dart';

@immutable
sealed class ChatRoomState {}

final class ChatRoomInitialState extends ChatRoomState {}

final class ChatRoomLoadingState extends ChatRoomState {}

final class ChatRoomSuccessState extends ChatRoomState {
  final ChatRoom chatRoom;

  ChatRoomSuccessState(this.chatRoom);
}

final class ChatRoomErrorState extends ChatRoomState {
  final String error;

  ChatRoomErrorState(this.error);
}
