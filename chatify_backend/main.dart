import 'dart:io';

import 'package:chatify_backend/src/env/env.dart';
import 'package:chatify_backend/src/repositories/message_repository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:supabase/supabase.dart';

late MessageRepository messageRepository;

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  final supabaseClient = SupabaseClient(
    Env.SUPABASE_URL,
    Env.SUPABASE_SERVICE_ROLE_KEY
  );
  messageRepository = MessageRepository(supabaseClient: supabaseClient);
  return serve(handler, ip, port);
}