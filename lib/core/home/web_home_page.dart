import 'package:chatify/chat/presentation/pages/web_chat_page.dart';
import 'package:flutter/material.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebChatPage(),
    );
  }
}
