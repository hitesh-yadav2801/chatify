import 'package:chatify/core/common/entities/user.dart';
import 'package:equatable/equatable.dart';

class ChatRoom extends Equatable {
  final String id;
  final List<User>? participants;

  const ChatRoom(
    this.participants, {
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
