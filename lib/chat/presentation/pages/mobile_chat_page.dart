import 'package:chatify/chat/domain/use_cases/create_chat_room.dart';
import 'package:chatify/chat/presentation/blocs/my_friends_bloc/my_friends_bloc.dart';
import 'package:chatify/chat/presentation/blocs/my_friends_bloc/my_friends_bloc.dart';
import 'package:chatify/chat/presentation/pages/mobile_chat_room_page.dart';
import 'package:chatify/core/common/widgets/loader.dart';
import 'package:chatify/core/common/widgets/profile_widget.dart';
import 'package:chatify/core/theme/style.dart';
import 'package:chatify/core/utils/show_snackbar.dart';
import 'package:chatify/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MobileChatPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const MobileChatPage());
  const MobileChatPage({super.key});

  @override
  State<MobileChatPage> createState() => _MobileChatPageState();
}

class _MobileChatPageState extends State<MobileChatPage> {

  @override
  void initState() {
    super.initState();
    context.read<MyFriendsBloc>().add(GetMyFriendsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyFriendsBloc, MyFriendsState>(
      listener: (context, state) {
        if (state is MyFriendsErrorState) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is MyFriendsLoadingState) {
          return const Loader();
        } else if(state is MyFriendsLoadedState) {
          return Scaffold(
            body: ListView.builder(
              itemCount: state.chatRooms.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MobileChatRoomPage(chatRoom: state.chatRooms[index])));
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
                    title: Text(
                      state.chatRooms[index].participants![1].name,
                    ),
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
        return const SizedBox();
      },
    );
  }
}

