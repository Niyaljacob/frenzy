import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/pages/home/widgets/post_card.dart';
import 'package:frenzy/views/pages/home/suggestion/suggestion.dart';

String logginedUserToken = '';
String logginedUserId = '';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
   final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: screenSize.height*0.048,
          child: Image.asset(Theme.of(context).brightness==Brightness.light? singupdark:singuplight)),
           actions: [
          IconButton(
            icon: const Icon(Icons.person_search_rounded,size: 35,color: primary,), 
            onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return const SuggestionPage();
             }));
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          kheight15,
          PostCard(
            profilePicUrl: 'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?cs=srgb&dl=pexels-andrewpersonaltraining-697509.jpg&fm=jpg',
            name: 'John Doe',
            postedTime: '2 hours ago',
            postImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ07WTuqB_-Mggp3awTkidhrH5jZJk_zfbHJw&s',
            description: 'This is a description of the post.bdhfvbhdbvsbdkjvbjdbjvgjdsbvjbdjkvjkfvjjkdvjjkdfvbdfvkj',
            likes: 123,
            comments: 45,
          ),
          PostCard(
            profilePicUrl: 'https://plus.unsplash.com/premium_photo-1673866484792-c5a36a6c025e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
            name: 'Amal John',
            postedTime: '4 hours ago',
            postImageUrl: 'https://www.malemodelscene.net/wp-content/uploads/2017/03/Sylvester-Ulv-Henriksen-Wallpaper-Magazine-Sean-Alexander-Geraghty-00.jpg',
            description: 'This is a description of the post.bdhfvbhdbvsbdkjvbjdbjvgjdsbvjbdjkvjkfvjjkdvjjkdfvbdfvkj',
            likes: 123,
            comments: 45,
          ),
          PostCard(
            profilePicUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCvFCNx3XOOU9GirFqWfVMedEN_EIzJS-aKg&s',
            name: 'Dhiya Jacob',
            postedTime: '5 hours ago',
            postImageUrl: 'https://images.squarespace-cdn.com/content/v1/586b82209f7456a21265feec/1493042606639-QXRVWHH7VL3DF1HKSV3X/roberto-nickson-48063',
            description: 'This is a description of the post.bdhfvbhdbvsbdkjvbjdbjvgjdsbvjbdjkvjkfvjjkdvjjkdfvbdfvkj',
            likes: 123,
            comments: 45,
          ),
          PostCard(
            profilePicUrl: 'https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp',
            name: 'Anandhu ',
            postedTime: '7 hours ago',
            postImageUrl: 'https://w0.peakpx.com/wallpaper/143/88/HD-wallpaper-man-in-suit-suit-male-model-interior-black-tie-man-chair-business.jpg',
            description: 'This is a description of the post.bdhfvbhdbvsbdkjvbjdbjvgjdsbvjbdjkvjkfvjjkdvjjkdfvbdfvkj',
            likes: 123,
            comments: 45,
          ),
        ],
      ),
    );
  }
}

