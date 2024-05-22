import 'package:chatify/auth/data/remote/models/user_model.dart';
import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:uuid/uuid.dart';

class ChatRoomModel extends ChatRoom {
  const ChatRoomModel(
    super.participants, {
    required super.id,
  });

  ChatRoomModel copyWith({
    List<UserModel>? participants,
    String? id,
  }) {
    return ChatRoomModel(
      participants ?? this.participants,
      id: id ?? this.id,
    );
  }

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      const [],
      id: json['id'] ?? const Uuid().v4(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
