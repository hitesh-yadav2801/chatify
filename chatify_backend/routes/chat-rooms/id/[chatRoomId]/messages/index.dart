import 'dart:async';
import 'dart:io';

import 'package:chatify_backend/src/repositories/message_repository.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context, String chatRoomId) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, chatRoomId);
    case HttpMethod.post:
    case HttpMethod.put:
    case HttpMethod.delete:
    case HttpMethod.patch:
    case HttpMethod.head:
    case HttpMethod.options:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, String chatRoomId) async {
  final messageRepository = context.read<MessageRepository>();
  try {
    final messages = await messageRepository.fetchMessages(chatRoomId);
    return Response.json(
      body: {'messages': messages},
    );
  } catch (err) {
    return Response.json(
      body: {'error': err.toString()},
      statusCode: HttpStatus.internalServerError,
    );
  }
}
