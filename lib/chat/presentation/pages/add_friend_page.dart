import 'package:chatify/chat/presentation/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:chatify/chat/presentation/blocs/chat_room_bloc/chat_room_bloc.dart';
import 'package:chatify/core/common/widgets/loader.dart';
import 'package:chatify/core/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddFriendPage());

  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatRoomBloc, ChatRoomState>(
      listener: (context, state) {
        if (state is ChatRoomErrorState) {
          showSnackBar(context, state.error);
        } else if (state is ChatRoomSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is ChatRoomLoadingState) {
          return const Loader();
        }
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Enter email...",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<ChatRoomBloc>().add(CreateChatRoomEvent(controller.text));
                },
                icon: const Icon(CupertinoIcons.add_circled),
              ),
            ],
          ),
        );
      },
    );
  }
}
