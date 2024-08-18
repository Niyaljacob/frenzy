import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/common_model/explore_users_user_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:frenzy/views/bloc/get_connection_bloc/get_connections_bloc.dart';
import 'package:frenzy/views/bloc/login_user_details_bloc/login_user_details_bloc.dart';
import 'package:frenzy/views/bloc/profile_post_bloc/profile_bloc.dart';
import 'package:frenzy/views/pages/search/widget/explor_ser_profile_sessions.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';

class ScreenExploreUserProfile extends StatefulWidget {
  final String userId;
  final UserIdSearchModel user;
  const ScreenExploreUserProfile(
      {super.key, required this.userId, required this.user});

  @override
  State<ScreenExploreUserProfile> createState() =>
      _ScreenExploreUserProfileState();
}

class _ScreenExploreUserProfileState extends State<ScreenExploreUserProfile> {
  String posts = '';
  @override
  void initState() {
    context
        .read<ProfileBloc>()
        .add(ProfileInitialPostFetchEvent(userId: widget.userId));
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
      context
          .read<GetConnectionsBloc>()
          .add(ConnectionsInitilFetchEvent(userId: widget.user.id));
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name ?? widget.user.userName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : black,
        toolbarHeight: 40,
      ),
      body: SafeArea(
        child: MultiBlocBuilder(
          blocs: [
            context.watch<LoginUserDetailsBloc>(),
            context.watch<ProfileBloc>(),
            context.watch<FetchFollowingBloc>(),
            context.watch<GetConnectionsBloc>(),
            context.watch<FollowUnfollowBloc>(),
          ],
          builder: (context, state) {
            var state2= state[1];
            if(state2 is ProfilePostFetchSuccesfulState){
              posts = state2.posts.length.toString();
            }
            return NestedScrollView(
              headerSliverBuilder:  (context, innerBoxIsScrolled){
                return [
                  SliverToBoxAdapter(
                    child: ExploreUserProfileSession1(
                      user: widget.user,
                      media: size,
                      profileImage: widget.user.profilePic,
                      coverImage: widget.user.backGroundImage,
                      userName: widget.user.userName,
             
                      bio: widget.user.bio ,
                      onEditProfile: () {},
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ExploreUserProfileSessions2(
                      onPostsTap: (){}, 
                      onFollowersTap: (){}, 
                      onFollowingTap: (){}),
                  )
                ];
                
              },
              body: const Column(
                children: [
                  Text('Posts',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  kheight,
                  Expanded(child: ExploreSession3()),
                ],
              ),
              );
          },
        )),
    );
  }
}
