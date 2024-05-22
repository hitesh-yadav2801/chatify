part of 'my_friends_bloc.dart';

@immutable
sealed class MyFriendsState {}

final class MyFriendsInitialState extends MyFriendsState {}

final class MyFriendsLoadingState extends MyFriendsState {}

final class MyFriendsLoadedState extends MyFriendsState {
  final List<ChatRoom> chatRooms;

  MyFriendsLoadedState(this.chatRooms);
}

final class MyFriendsErrorState extends MyFriendsState {
  final String message;

  MyFriendsErrorState(this.message);
}
