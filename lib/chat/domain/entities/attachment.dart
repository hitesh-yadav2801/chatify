import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum AttachmentType { image, video, audio }

class Attachment extends Equatable {
  final String id;
  final String messageId;
  final AttachmentType type;
  final String attachmentUrl;

  const Attachment({
    required this.id,
    required this.messageId,
    required this.type,
    required this.attachmentUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] ?? const Uuid().v4(),
      messageId: json['messageId'] ?? '',
      type: AttachmentType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => AttachmentType.image,
      ),
      attachmentUrl: json['attachmentUrl'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, messageId, type, attachmentUrl];
}
