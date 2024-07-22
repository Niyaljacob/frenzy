import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frenzy/views/pages/signin_page/signin.dart';
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
    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SigninPage(),
        ),
      );
    });
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