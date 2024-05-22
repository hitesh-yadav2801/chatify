import 'package:chatify/chat/domain/entities/attachment.dart';
import 'package:uuid/uuid.dart';

class AttachmentModel extends Attachment {
  const AttachmentModel({
    required super.id,
    required super.messageId,
    required super.type,
    required super.attachmentUrl,
  });

  Attachment copyWith({
    String? id,
    String? messageId,
    AttachmentType? type,
    String? attachmentUrl,
  }) {
    return Attachment(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      type: type ?? this.type,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      id: json['id'] ?? const Uuid().v4(),
      messageId: json['messageId'] ?? '',
      type: AttachmentType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => AttachmentType.image,
      ),
      attachmentUrl: json['attachmentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messageId': messageId,
      'type': type.toString().split('.').last,
      'attachmentUrl': attachmentUrl,
    };
  }
}
