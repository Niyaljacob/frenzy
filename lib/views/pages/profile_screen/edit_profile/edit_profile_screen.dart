import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/functions/pick_image.dart';
import 'package:frenzy/utils/validation.dart';
import 'package:frenzy/views/bloc/edit_user_profile/edit_user_profile_bloc.dart';
import 'package:frenzy/views/bloc/login_user_details_bloc/login_user_details_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/class_widgets/textfield.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/custom_material_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.cvImage, required this.prImage});
  final String cvImage;
  final String prImage;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ValueNotifier<String> profileImageNotifier = ValueNotifier('');
  final ValueNotifier<String> coverImageNotifier = ValueNotifier('');

  String profileImageUrl = '';
  String coverImageUrl = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: primary,
        elevation: 0,
      ),
      body: BlocConsumer<LoginUserDetailsBloc, LoginUserDetailsState>(
        listener: (context, state) {
          if (state is LoginUserDetailsDataFetchSuccesState) {
            nameController.text = state.userModel.userName;
            bioController.text = state.userModel.bio ?? '';
            profileImageUrl = state.userModel.profilePic;
            coverImageUrl = state.userModel.backGroundImage;
          }
        },
        builder: (context, userDetailsState) {
          return BlocConsumer<EditUserProfileBloc, EditUserProfileState>(
            listener: (context, state) {
              if (state is EditUserProfileSuccesState) {
                customSnackbar(context, 'Profile details updated', primary);
                context
                    .read<LoginUserDetailsBloc>()
                    .add(OnLoginedUserDataFetchEvent());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ValueListenableBuilder<String>(
                        valueListenable: coverImageNotifier,
                        builder: (context, coverImagePath, child) {
                          return Container(
                            width: size.width,
                            height: size.height * 0.30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: coverImagePath.isNotEmpty
                                    ? FileImage(File(coverImagePath))
                                    : CachedNetworkImageProvider(widget.cvImage)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  bottom: -50,
                                  left: 20,
                                  child: ValueListenableBuilder<String>(
                                    valueListenable: profileImageNotifier,
                                    builder:
                                        (context, profileImagePath, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          pickImage(profileImageNotifier);
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            border: Border.all(
                                                width: 5, color: whiteColor),
                                            image: DecorationImage(
                                              image: profileImagePath.isNotEmpty
                                                  ? FileImage(
                                                      File(profileImagePath))
                                                  : CachedNetworkImageProvider(
                                                          widget.prImage)
                                                      as ImageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 10,
                                                offset: Offset(0, 5),
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                right: 10,
                                                bottom: 10,
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.7),
                                                  child: const Icon(Icons.edit,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  bottom: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      pickImage(coverImageNotifier);
                                    },
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.7),
                                      child: const Icon(Icons.edit,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 80),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: 'Edit name',
                              controller: nameController,
                              validator: validateUsername,
                              
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              
                              hintText: 'Bio',
                              controller: bioController,
                              validator: validateBio,
                             
                            ),
                            SizedBox(height: 40),
                            BlocBuilder<EditUserProfileBloc, EditUserProfileState>(
                              builder: (context, state) {
                                if (state is EditUserProfileLoadingState ||
                                    state
                                        is LoginUserDetailsDataFetchLoadingState) {
                                  return loadingButton(
                                      media: size,
                                      onPressed: () {},
                                      color: primary);
                                }
                                return customMaterialButton(
                                  borderRadius: 20,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (userDetailsState
                                          is LoginUserDetailsDataFetchSuccesState) {
                                        context.read<EditUserProfileBloc>().add(
                                              OnEditProfileButtonClickedEvent(
                                                  name: nameController.text,
                                                  bio: bioController.text,
                                                  image: profileImageNotifier
                                                      .value,
                                                  imageUrl: userDetailsState
                                                      .userModel.profilePic,
                                                  bgImage:
                                                      coverImageNotifier.value,
                                                  bgImageUrl: userDetailsState
                                                      .userModel
                                                      .backGroundImage),
                                            );
                                      }
                                    }
                                  },
                                  text: 'Save',
                                  color: primary,
                                  width: size.width,
                                  height: size.height * 0.06,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
