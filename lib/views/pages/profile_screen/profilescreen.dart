import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/user_suggestions/logined_user_details_model.dart';
import 'package:frenzy/views/bloc/fetch_followers_bloc/fetch_followers_bloc.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/bloc/fetch_my_post/bloc/fetchmypost_bloc.dart';
import 'package:frenzy/views/bloc/fetch_saved_post/fetch_saved_posts_bloc.dart';
import 'package:frenzy/views/bloc/login_user_details_bloc/login_user_details_bloc.dart';
import 'package:frenzy/views/pages/profile_screen/edit_profile/edit_profile_screen.dart';
import 'package:frenzy/views/pages/profile_screen/setting_page/setting_screen.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/profile_sessions.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/shimmer_widget.dart';

String logginedUserProfileImage = '';
String profilepageUserId = '';
String profileuserName = '';
String coverImageUrl = '';

LoginUserModel userdetails = LoginUserModel(
    id: '',
    userName: '',
    email: '',
    phone: '',
    online: true,
    blocked: false,
    verified: false,
    role: '',
    isPrivate: false,
    createdAt: DateTime(20242024 - 08 - 14),
    updatedAt: DateTime(20242024 - 08 - 14),
    profilePic: '',
    backGroundImage: '');



class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
  
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  void initState() {
  context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
  context.read<FetchFollowersBloc>().add(OnfetchAllFollowersEvent());
  context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
  context.read<FetchmypostBloc>().add(FetchAllMyPostsEvent());
  context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text('Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.menu),
            )
          ],
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 2, 
            child: BlocBuilder<LoginUserDetailsBloc, LoginUserDetailsState>(
              builder:(context, state) {
                if(state is LoginUserDetailsDataFetchSuccesState){
                  profileuserName =
                    state.userModel.name ?? state.userModel.userName;
                logginedUserProfileImage = state.userModel.profilePic;
                profilepageUserId = state.userModel.id;
                userdetails = state.userModel;
                coverImageUrl = state.userModel.backGroundImage;
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled){
                    return [
                      SliverToBoxAdapter(
                        child: ProfileSession1(
                          media: size, 
                          profileImage: logginedUserProfileImage, 
                          coverImage: coverImageUrl, 
                          userName: profileuserName, 
                          bio: state.userModel.bio ?? '', 
                          onEditProfile: (){
                             Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => EditProfileScreen(
                                  cvImage: coverImageUrl,
                                  prImage: logginedUserProfileImage,
                                ),
                              ),
                            );
                          }),
                      ),
                      SliverToBoxAdapter(
                        child: ProfileSession2(
                          onPostsTap: () {
                            if (context.read<FetchmypostBloc>().state
                                is FetchMyPostSuccesState) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => ScreenMyPost(
                              //       index: 0,
                              //       post: (context.read<FetchMyPostBloc>().state
                              //               as FetchMyPostSuccesState)
                              //           .posts,
                              //     ),
                              //   ),
                              // );
                            }
                          },
                          onFollowersTap: () {
                            if (context.read<FetchFollowersBloc>().state
                                is FetchFollowersSuccesState) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (ctx) => ScreenFollowers(
                              //       model: (context
                              //               .read<FetchFollowersBloc>()
                              //               .state as FetchFollowersSuccesState)
                              //           .followersModel,
                              //     ),
                              //   ),
                              // );
                            }
                          },
                          onFollowingTap: () {
                            if (context.read<FetchFollowingBloc>().state
                                is FetchFollowingSuccesState) {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (ctx) => const ScreenFollowing(),
                              //   ),
                              // );
                            }
                          },
                        ),
                      ),
                      
                    ];
                  },
                   body: const ProfileSession3(),
                   );
                }else if (state is LoginUserDetailsDataFetchLoadingState) {
                return profileImageShimmerContainer(context);
              }else {
                return const Center(child: Text('Failed to load profile'));
              }
              },
              )
              )
              ),
      ),
    );
  }
}
