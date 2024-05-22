part of 'chat_room_bloc.dart';

@immutable
sealed class ChatRoomEvent {}

final class CreateChatRoomEvent extends ChatRoomEvent {
  final String email;

  CreateChatRoomEvent(this.email);
}
