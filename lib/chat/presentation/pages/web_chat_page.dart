import 'package:chatify/chat/presentation/pages/mobile_chat_room_page.dart';
import 'package:chatify/chat/presentation/pages/web_chat_room_page.dart';
import 'package:chatify/chat/presentation/widgets/chat_list.dart';
import 'package:chatify/chat/presentation/widgets/web_chat_app_bar.dart';
import 'package:chatify/chat/presentation/widgets/web_profile_bar.dart';
import 'package:chatify/chat/presentation/widgets/web_search_bar.dart';
import 'package:chatify/core/theme/style.dart';
import 'package:flutter/material.dart';

class WebChatPage extends StatelessWidget {
  const WebChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WebProfileBar(),
                  WebSearchBar(),
                  ChatList(),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.67,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroundImage.png'),
                  fit: BoxFit.fill
              ),
            ),
            child: Column(
              children: [
                const WebChatAppBar(),
                const Expanded(child: WebChatRoomPage()),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: chatBarMessage,
                      border: Border(
                        bottom: BorderSide(color: dividerColor),
                      )
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: searchBarColor,
                              hintText: 'Type a message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 10),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.grey,
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
