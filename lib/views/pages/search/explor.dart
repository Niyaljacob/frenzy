import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/dummydata/explorpage.dart';

class ExplorScreen extends StatelessWidget {
   const ExplorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Explore',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kheight20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
            ),
            MasonryView(
              listOfItem: explor, 
              numberOfColumn: 2, 
              itemBuilder: (item){
                return Image.asset(item);
              })
          ],
        ),
      )
    );
  }
}