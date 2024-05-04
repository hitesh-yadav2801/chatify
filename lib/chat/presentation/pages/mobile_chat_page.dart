
import 'package:chatify/chat/presentation/pages/mobile_chat_room_page.dart';
import 'package:chatify/core/common/widgets/profile_widget.dart';
import 'package:chatify/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MobileChatPage extends StatelessWidget {
  const MobileChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MobileChatRoomPage()));
            },
            child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: profileWidget(),
                ),
              ),
              title: const Text("Name"),
              subtitle: const Text(
                "Last message",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                DateFormat.jm().format(DateTime.now()),
                style: const TextStyle(fontSize: 13, color: greyColor),
              ),
            ),
          );
        },
      ),
    );
  }
}

