import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/custom_material_button.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/profile_container.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/user_name_bio.dart';

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