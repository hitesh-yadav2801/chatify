import 'package:chatify/auth/presentation/blocs/auth_bloc.dart';
import 'package:chatify/auth/presentation/pages/login_page.dart';
import 'package:chatify/chat/presentation/pages/add_friend_page.dart';
import 'package:chatify/chat/presentation/pages/mobile_chat_page.dart';
import 'package:chatify/core/common/widgets/loader.dart';
import 'package:chatify/core/theme/style.dart';
import 'package:chatify/core/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _currentTabIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailureState) {
          showSnackBar(context, state.message);
        } else if (state is AuthLogoutSuccessState) {
          Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Loader();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              "Chatify",
              style: TextStyle(
                color: greyColor,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            actions: [
              Row(
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: greyColor,
                    size: 28,
                  ),
                  const SizedBox(width: 25),
                  const Icon(
                    Icons.more_vert,
                    color: greyColor,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutEvent());
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: greyColor,
                      size: 28,
                    ),
                  )
                ],
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              labelColor: tabColor,
              unselectedLabelColor: greyColor,
              indicatorColor: tabColor,
              tabs: const [
                Tab(
                  child: Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Calls',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton:
          switchFloatingActionButtonOnTabIndex(_currentTabIndex),
          body: TabBarView(
            controller: _tabController,
            children: [
              const MobileChatPage(),
              Container(),
              Container(),
            ],
          ),
        );
      },
    );
  }

  switchFloatingActionButtonOnTabIndex(int index) {
    switch (index) {
      case 0:
        return SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {
              Navigator.push(context, AddFriendPage.route());
            },
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );

      case 1:
        return SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        );
      case 2:
        return SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add_call,
              color: Colors.white,
            ),
          ),
        );
      default:
        return SizedBox(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            backgroundColor: tabColor,
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
        );
    }
  }
}
