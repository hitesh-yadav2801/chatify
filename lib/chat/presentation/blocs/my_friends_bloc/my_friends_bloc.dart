import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:chatify/chat/domain/use_cases/get_my_friends.dart';
import 'package:chatify/core/usecase/usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_friends_event.dart';

part 'my_friends_state.dart';

class MyFriendsBloc extends Bloc<MyFriendsEvent, MyFriendsState> {
  final GetMyFriends _getMyFriends;

  MyFriendsBloc({required GetMyFriends getMyFriends})
      : _getMyFriends = getMyFriends,
        super(MyFriendsInitialState()) {
    on<MyFriendsEvent>((_, emit) => emit(MyFriendsLoadingState()));
    on<GetMyFriendsEvent>(_onGetMyFriendsEvent);
  }

  void _onGetMyFriendsEvent(
      GetMyFriendsEvent event, Emitter<MyFriendsState> emit) async {
    final response = await _getMyFriends(NoParams());

    response.fold(
      (failure) => emit(MyFriendsErrorState(failure.message)),
      (chatRooms) => emit(MyFriendsLoadedState(chatRooms)),
    );
  }
}
