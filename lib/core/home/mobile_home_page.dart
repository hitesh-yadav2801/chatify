import 'package:chatify/chat/presentation/pages/mobile_chat_page.dart';
import 'package:chatify/core/theme/style.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
        actions: const [
          Row(
            children: [
              Icon(
                Icons.camera_alt_outlined,
                color: greyColor,
                size: 28,
              ),
              SizedBox(width: 25),
              Icon(
                Icons.search,
                color: greyColor,
                size: 28,
              ),
              SizedBox(width: 10),
              Icon(
                Icons.more_vert,
                color: greyColor,
                size: 28,
              ),
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
          MobileChatPage(),
          Container(),
          Container(),
        ],
      ),
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
            onPressed: () {},
            shape: const CircleBorder(),
            child: const Icon(
              Icons.message,
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
