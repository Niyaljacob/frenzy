import 'package:flutter/material.dart';
import 'package:frenzy/model/common_model/explore_users_user_model.dart';
import 'package:frenzy/model/common_model/followers_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/pages/search/widget/explore_user_profile.dart';

class ScreenFollowers extends StatelessWidget {
  const ScreenFollowers({super.key, required this.model});
  final FollowersModel model;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Followers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: model.totalCount == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_off,
                      size: size.height * 0.1,
                      color: grey,
                    ),
                    kheight,
                    const Text(
                      'No followers yet',
                      style: TextStyle(fontSize: 18, color: grey),
                    )
                  ],
                ),
              )
            : ListView.builder(
  itemCount: model.totalCount,
  itemBuilder: (context, index) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey[850],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.withOpacity(0.3)
                : Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          radius: size.height * 0.03,
          backgroundImage: NetworkImage(model.followers[index].profilePic),
        ),
        title: Text(
          model.followers[index].userName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        subtitle: Text(
          model.followers[index].bio ?? 'No bio available',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey[700]
                : Colors.grey[300],
          ),
        ),
        trailing: const Icon(Icons.arrow_circle_right_outlined,size: 29,color: whiteColor,),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenExploreUserProfile(
                userId: model.followers[index].id,
                user: UserIdSearchModel(
                  bio: model.followers[index].bio ?? '',
                  id: model.followers[index].id,
                  userName: model.followers[index].userName,
                  email: model.followers[index].userName,
                  profilePic: model.followers[index].profilePic,
                  online: model.followers[index].online,
                  blocked: model.followers[index].blocked,
                  verified: model.followers[index].verified,
                  role: model.followers[index].role,
                  isPrivate: model.followers[index].isPrivate,
                  backGroundImage: model.followers[index].backGroundImage,
                  createdAt: model.followers[index].createdAt,
                  updatedAt: model.followers[index].updatedAt,
                  v: model.followers[index].v,
                ),
              ),
            ),
          );
        },
      ),
    ),
  ),
)

              );
  }
}
