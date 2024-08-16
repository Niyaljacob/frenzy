import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/fetch_followers_bloc/fetch_followers_bloc.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/bloc/fetch_my_post/bloc/fetchmypost_bloc.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/custom_material_button.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/custom_text_column.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/post_and_saved_grid.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/profile_container.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/user_name_bio.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileSession1 extends StatelessWidget {
  final Size media;
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;
  final VoidCallback onEditProfile;

  const ProfileSession1({
    required this.media,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
    required this.onEditProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profileContainer(media, profileImage, coverImage),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: customMaterialButton(
                  context: context,
                  color: primary,
                  onPressed: onEditProfile,
                  text: 'Edit Profile',
                  width: media.height * 0.12,
                  height: media.height * 0.05,
                  textStyle: const TextStyle(fontSize: 16),
                  borderRadius: 20),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: userNameAndBio(userName, bio),
        ),
      ],
    );
  }
}

class ProfileSession2 extends StatelessWidget {
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;

  const ProfileSession2({
    required this.onPostsTap,
    required this.onFollowersTap,
    required this.onFollowingTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<FetchmypostBloc, FetchmypostState>(
            builder: (context, state) {
              return state is FetchMyPostSuccesState
                  ? customTextColumn(
                      text1: state.posts.length.toString(),
                      text2: 'Posts',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      onTap: onPostsTap,
                    )
                  : customTextColumn(
                      text1: '0',
                      text2: 'Posts',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      onTap: () {});
            },
          ),
          BlocBuilder<FetchFollowersBloc, FetchFollowersState>(
            builder: (context, state) {
              return state is FetchFollowersSuccesState
                  ? customTextColumn(
                      text1: state.followersModel.followers.length.toString(),
                      text2: 'Followers',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      onTap: onFollowersTap,
                    )
                  : customTextColumn(
                      text1: '0',
                      text2: 'Followers',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      onTap: onFollowersTap,
                    );
            },
          ),
          BlocBuilder<FetchFollowingBloc, FetchFollowingState>(
            builder: (context, state) {
              return state is FetchFollowingSuccesState
                  ? customTextColumn(
                      text1: state.model.following.length.toString(),
                      text2: 'Following',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      onTap: onFollowingTap,
                    )
                  : customTextColumn(
                      text1: '0',
                      text2: 'Following',
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      onTap: onFollowingTap,
                    );
            },
          ),
        ],
      ),
    );
  }
}


class ProfileSession3 extends StatelessWidget {
  const ProfileSession3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TabBar(
            labelColor: primary,
            unselectedLabelColor: grey,
            indicatorColor: primary,
            tabs: [
              Tab(text: 'My Posts'),
              Tab(text: 'Saved Posts'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              BlocBuilder<FetchmypostBloc, FetchmypostState>(
                builder: (context, state) {
                  if (state is FetchMyPostSuccesState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyPostsGrid(post: state.posts),
                    );
                  } else if (state is FetchMyPostLoadingState) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: primary,
                        size: 30,
                      ),
                    );
                  } else {
                    return const Center(child: Text('No posts available'));
                  }
                },
              ),
              const SavedPostsGrid(),
            ],
          ),
        ),
      ],
    );
  }
}

