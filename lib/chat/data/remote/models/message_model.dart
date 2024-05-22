import 'package:chatify/chat/data/remote/models/attachment_model.dart';
import 'package:chatify/chat/domain/entities/message.dart';
import 'package:uuid/uuid.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.chatRoomId,
    required super.senderUserId,
    required super.receiverUserId,
    required super.content,
    required super.attachment,
    required super.createdAt,
  });

  MessageModel copyWith({
    String? id,
    String? chatRoomId,
    String? senderUserId,
    String? receiverUserId,
    String? content,
    AttachmentModel? attachment,
    DateTime? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderUserId: senderUserId ?? this.senderUserId,
      receiverUserId: receiverUserId ?? this.receiverUserId,
      content: content ?? this.content,
      attachment: attachment ?? this.attachment,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? const Uuid().v4(),
      chatRoomId: json['chat_room_id'] ?? '',
      senderUserId: json['sender_user_id'] ?? '',
      receiverUserId: json['receiver_user_id'] ?? '',
      content: json['content'],
      attachment: json['attachment'] != null
          ? AttachmentModel.fromJson(json['attachment'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_room_id': chatRoomId,
      'sender_user_id': senderUserId,
      'receiver_user_id': receiverUserId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }

}
