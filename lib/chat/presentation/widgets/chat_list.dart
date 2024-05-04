import 'package:chatify/core/common/widgets/profile_widget.dart';
import 'package:chatify/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10, // Change this value to the actual number of chats
      itemBuilder: (context, index) {
        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: profileWidget(),
            ),
          ),
          title: const Text("Name"), // Replace with dynamic data
          subtitle: const Text(
            "Last message", // Replace with dynamic data
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            DateFormat.jm().format(DateTime.now()), // Replace with dynamic data
            style: const TextStyle(fontSize: 13, color: greyColor),
          ),
        );
      },
    );
  }
}
