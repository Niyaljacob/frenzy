import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/explore_users_user_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/common_widgets/list_tile.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/shimmer_widget.dart';
import 'package:frenzy/views/pages/search/widget/explore_user_profile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ScreenFollowing extends StatelessWidget {
  const ScreenFollowing({super.key});

  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Following',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners:[
           BlocListener<FetchFollowingBloc, FetchFollowingState>(
          listener:(context, state) {
            if (state is FetchFollowingErrorState) {
                customSnackbar(context, 'failed..!', red);
              }
          },
          ), 
          BlocListener<FollowUnfollowBloc, FollowUnfollowState>(
            listener:(context, state) {
              if (state is UnFollowUserSuccesfulState) {
                context
                    .read<FetchFollowingBloc>()
                    .add(OnFetchFollowingUsersEvent());
              } else if (state is UnFollowUserErrorState) {}
            },)
          ],
        child: BlocBuilder<FetchFollowingBloc, FetchFollowingState>(
          builder:(context, state) {
            if (state is FetchFollowingLoadingState ||
                state is UnFollowUserLoadingState) {
              return ListView.builder(
                itemBuilder: (context, index) => shimmerTile(),
                itemCount: 5,
              );
          }else if(state is FetchFollowingSuccesState){
            final followings = state.model.following;
            if(followings.isEmpty){
              return const Center(
                child: Text('No followers yet'),
              );
            }
            return ListView.builder(
              itemBuilder:(context, index)=>SizedBox(
                height: 68,
                child: CustomListTile(
                  onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScreenExploreUserProfile(
                                  userId: state.model.following[index].id,
                                  user: UserIdSearchModel(
                                      id: state.model.following[index].id,
                                      userName:
                                          state.model.following[index].userName,
                                      email: state.model.following[index].email,
                                      profilePic: state
                                          .model.following[index].profilePic,
                                      online:
                                          state.model.following[index].online,
                                      blocked:
                                          state.model.following[index].blocked,
                                      verified:
                                          state.model.following[index].verified,
                                      role: state.model.following[index].role,
                                      isPrivate: state
                                          .model.following[index].isPrivate,
                                      backGroundImage: state.model
                                          .following[index].backGroundImage,
                                      createdAt: DateTime.parse(state
                                          .model.following[index].createdAt),
                                      updatedAt: DateTime.parse(state
                                          .model.following[index].updatedAt),
                                      v: state.model.following[index].v,
                                      bio: state.model.following[index].bio ??
                                          '')),
                            ));
                      },
                  profileImageUrl: followings[index].profilePic,
                  buttonText: 'unfollow', 
                  titleText: followings[index].userName, 
                  imageSize: size.height * 0.05,
                  backgroundColor: whiteColor, 
                  borderRadius: BorderRadius.circular(100)),
              ),
              itemCount: followings.length,
              );
          }else{
            return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: primary,
                  size: 30,
                ),
              );
          }
          }
          )
          ),
    );
  }
}
