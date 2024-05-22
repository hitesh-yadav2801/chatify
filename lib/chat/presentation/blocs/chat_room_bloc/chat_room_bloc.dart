import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:chatify/chat/domain/use_cases/create_chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_room_event.dart';

part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final CreateChatRoom _createChatRoom;

  ChatRoomBloc({
    required CreateChatRoom createChatRoom,
  })  : _createChatRoom = createChatRoom,
        super(ChatRoomInitialState()) {
    on<ChatRoomEvent>((_, emit) => emit(ChatRoomLoadingState()));
    on<CreateChatRoomEvent>(_onCreateChatRoom);
  }

  void _onCreateChatRoom(
    CreateChatRoomEvent event,
    Emitter<ChatRoomState> emit,
  ) async {
    final response = await _createChatRoom(event.email);

    response.fold(
      (failure) => emit(ChatRoomErrorState(failure.message)),
      (chatRoom) => emit(ChatRoomSuccessState(chatRoom)),
    );
  }
}
