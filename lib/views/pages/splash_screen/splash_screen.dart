import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/pages/first_page/bottom_nav_first_page.dart';
import 'package:frenzy/views/pages/signin_page/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
  
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/qqult.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    checkUserLogin(context);
  }

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}

Future<void> checkUserLogin(context) async {
  final preferences = await SharedPreferences.getInstance();
  final userLoggedIn = preferences.get(authKey);
  debugPrint(userLoggedIn.toString());
  if (userLoggedIn == null || userLoggedIn == false) {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SigninPage(),
    ));
  } else {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BottomNavFirstPage(),
    ));
  }
}