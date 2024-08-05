import 'package:flutter/material.dart';
import 'package:frenzy/views/pages/chat_page/chat_screen.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/bottomnav.dart';
import 'package:frenzy/views/pages/home/screen_home.dart';
import 'package:frenzy/views/pages/post_add/post_add_screen.dart';
import 'package:frenzy/views/pages/profile_screen/profilescreen.dart';
import 'package:frenzy/views/pages/search/explor.dart';


final ValueNotifier<int> currentPage = ValueNotifier(0);
class BottomNavFirstPage extends StatelessWidget {
   BottomNavFirstPage({super.key});

  final List<Widget>pages=[
    const HomeScreen(),
     const ExplorScreen(),
    PostAddScreen(),
    const ChatScreen(),
    const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => IndexedStack(
          index: value,
          children: pages,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => bottomNav(context),
      ),
    );
  }
}