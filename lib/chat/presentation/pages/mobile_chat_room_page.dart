import 'package:chatify/chat/domain/entities/chat_room.dart';
import 'package:chatify/chat/domain/entities/message.dart';
import 'package:chatify/chat/presentation/widgets/MyChatBubble.dart';
import 'package:chatify/chat/presentation/widgets/OtherUserChatBubble.dart';
import 'package:chatify/core/theme/style.dart';
import 'package:chatify/main.dart';
import 'package:flutter/material.dart';

class MobileChatRoomPage extends StatefulWidget {
  final ChatRoom chatRoom;

  const MobileChatRoomPage({super.key, required this.chatRoom});

  @override
  State<MobileChatRoomPage> createState() => _MobileChatRoomPageState();
}

class _MobileChatRoomPageState extends State<MobileChatRoomPage> {
  final messageController = TextEditingController();
  final List<Message> messages = [];

  @override
  void initState() {
    _loadMessages();
    _startWebSocket();
    messageRepository.subscribeToMessageUpdates((messageData) {
      final message = Message.fromJson(messageData);
      if (message.chatRoomId == widget.chatRoom.id) {
        messages.add(message);
        messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    final _messages = await messageRepository.fetchMessages(widget.chatRoom.id);
    _messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    setState(() {
      messages.addAll(_messages);
    });
  }

  void _sendMessage() async {
    final message = Message(
      chatRoomId: widget.chatRoom.id,
      senderUserId: widget.chatRoom.participants![0].id,
      receiverUserId: widget.chatRoom.participants![1].id,
      content: messageController.text,
      createdAt: DateTime.now(),
    );

    // setState(() {
    //   messages.add(message);
    // });

    await messageRepository.createMessage(message);
    messageController.clear();
  }

  _startWebSocket() {
    webSocketClient.connect(
      'ws://localhost:8080/ws',
      {
        'Authorization': 'Bearer ....',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = widget.chatRoom.participants![0];
    final otherUser = widget.chatRoom.participants![1];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
            ),
            const SizedBox(width: 10),
            Text(
              otherUser.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgroundImage.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  if (message.senderUserId == currentUser.id) {
                    return MyChatBubble(message: message.content.toString());
                  } else {
                    return OtherUserChatBubble(
                        message: message.content.toString());
                  }
                },
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
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
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: tabColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        _sendMessage();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
