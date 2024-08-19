import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/explore_users_user_model.dart';
import 'package:frenzy/model/common_model/following_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:frenzy/views/bloc/get_connection_bloc/get_connections_bloc.dart';
import 'package:frenzy/views/bloc/profile_post_bloc/profile_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/custom_text_column.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/profile_container.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/round_material_button.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/user_name_bio.dart';
import 'package:frenzy/views/pages/search/screen_others_user_post.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class ExploreUserProfileSession1 extends StatelessWidget {
  final Size media;
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;
  final VoidCallback onEditProfile;
  final UserIdSearchModel user;

  ExploreUserProfileSession1({
    required this.media,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
    required this.onEditProfile,
    super.key,
    required this.user,
  });
  List<Follower> followings = [];

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
              padding: const EdgeInsets.only(right: 10),
              child: BlocBuilder<FetchFollowingBloc, FetchFollowingState>(
  builder: (context, state) {
    String buttonText = 'Follow'; // Default text
    bool isFollowing = false;

    if (state is FetchFollowingSuccesState) {
      final FollowingsModel followingsModel = state.model;
      followings = followingsModel.following;

      // Check if the user is already being followed
      isFollowing = followings.any((following) => following.id == user.id);
      buttonText = isFollowing ? 'Unfollow' : 'Follow';
    }

    return customMaterialButtonround(
      borderRadius: 10,
      color: primary,
      onPressed: () {
        if (state is FetchFollowingSuccesState) {
          if (isFollowing) {
            // If already following, unfollow
            followings.removeWhere((element) => element.id == user.id);
            context.read<FollowUnfollowBloc>().add(
                OnUnFollowButtonClickedEvent(followeesId: user.id));
          } else {
            // If not following, follow
            followings.add(Follower(
                id: user.id,
                userName: user.userName,
                email: user.email,
                password: user.password ?? '',
                phone: user.phone,
                online: user.online,
                blocked: user.blocked,
                verified: user.verified,
                role: user.role,
                isPrivate: user.isPrivate,
                createdAt: formatDate(user.createdAt.toString()),
                updatedAt: formatDate(user.updatedAt.toString()),
                v: user.v,
                profilePic: user.profilePic,
                backGroundImage: user.backGroundImage));
            context.read<FollowUnfollowBloc>().add(
                OnFollowButtonClickedEvent(followeesId: user.id));
          }

          // Trigger UI updates
          context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
          context.read<GetConnectionsBloc>().add(
              ConnectionsInitilFetchEvent(userId: user.id));
        }
      },
      text: buttonText,
      width: media.height * 0.1,
      height: media.height * 0.05,
      textStyle: const TextStyle(fontSize: 16),
    );
  },
),

            ),
            MaterialButton(
              onPressed: () {},
              color: primary,
              child: const Text('message'),
            )
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
class ExploreUserProfileSessions2 extends StatelessWidget {
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;

  const ExploreUserProfileSessions2({
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
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfilePostFetchSuccesfulState) {
                return customTextColumn(
                    text1: state.posts.length.toString(),
                    text2: 'Posts',
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    onTap: () {});
              } else {
                return customTextColumn(
                    text1: '0',
                    text2: 'Posts',
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    onTap: () {});
              }
            },
          ),
          BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
            builder: (context, state) {
              if (state is GetConnectionsSuccesfulState) {
                return customTextColumn(
                  text1: state.followersCount.toString(),
                  text2: 'Followers',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  onTap: onFollowersTap,
                );
              } else {
                return customTextColumn(
                  text1: '0',
                  text2: 'Followers',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  onTap: onFollowersTap,
                );
              }
            },
          ),
          BlocBuilder<GetConnectionsBloc, GetConnectionsState>(
            builder: (context, state) {
              if (state is GetConnectionsSuccesfulState) {
                return customTextColumn(
                  text1: state.followingsCount.toString(),
                  text2: 'Following',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  onTap: onFollowersTap,
                );
              } else {
                return customTextColumn(
                  text1: '0',
                  text2: 'Following',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  onTap: onFollowersTap,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ExploreSession3 extends StatelessWidget {
  const ExploreSession3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfilePostFetchSuccesfulState) {
          if (state.posts.isNotEmpty) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScreenOtherUserPosts(posts: state.posts),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: CachedNetworkImage(
                        imageUrl: state.posts[index].image,
                        placeholder: (context, url) =>
                            LoadingAnimationWidget.fourRotatingDots(
                                color: grey, size: 30),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return errorStateWidget('No Posts ', const TextStyle(
  fontSize: 16,
  color: grey,
));
          }
        } else {
          return Center(
            child: LoadingAnimationWidget.fourRotatingDots(
                color: primary, size: 30),
          );
        }
      },
    );
  }
}
