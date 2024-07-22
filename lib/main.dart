import 'package:flutter/material.dart';
import 'package:frenzy/utils/themes.dart';
import 'package:frenzy/views/pages/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightModeTheme,
      darkTheme: Themes.darkModeTheme,
    
      home: SplashScreen(),
    );
  }
}

