import 'package:flutter/material.dart';
import 'package:frenzy/views/pages/home/widgets/appbar.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
              HomeAppBar(size: size),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight:Radius.circular(40)),
                  color: Color.fromARGB(255, 233, 232, 232)
                ),
                
                height: size.height,
              )
          ],
        ),
      ),
    );
  }
}

