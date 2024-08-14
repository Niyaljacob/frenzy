import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/user_suggestions/logined_user_details_model.dart';
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
              icon: const Icon(Icons.settings),
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
                    ];
                  },
                   body: Container()
                   );
                }else if (state is LoginUserDetailsDataFetchLoadingState) {
                return profileImageShimmerContainer(context);
              }else {
                return const Center(child: Text('Failed to load profile'));
              }
              },))),
      ),
    );
  }
}
