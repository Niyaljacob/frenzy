import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/confirmationdialog.dart';
import 'package:frenzy/views/pages/first_page/bottom_nav_first_page.dart';
import 'package:frenzy/views/pages/profile_screen/setting_page/about_us.dart';
import 'package:frenzy/views/pages/profile_screen/setting_page/privacy_policies.dart';
import 'package:frenzy/views/pages/profile_screen/setting_page/terms_conditions.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/settings_list_tile.dart';
import 'package:frenzy/views/pages/signin_page/signin.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
        

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          
          settingsListTile(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const TermsConditions(),
                  ),
                );
              },
              leading: const Icon(Icons.notes_outlined),
              title: 'Terms and Conditions',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )),
              settingsListTile(
            onTap: (){
              Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>const PrivacyPolicies()));
            }, 
            leading: const Icon(Icons.privacy_tip_outlined), 
            title: 'Privacy Policies', 
            trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )),
              settingsListTile(
            onTap: (){
              Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>const AboutUs()));
            }, 
            leading: const Icon(Icons.info_outline), 
            title: 'About Us', 
            trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )),
          settingsListTile(
              onTap: () async {
                confirmationDialog(
                    context: context,
                    title: 'Log Out!',
                    content: "Are you sure ?",
                    confirmButtonText: "confirm",
                    cancelButtonText: "cancel",
                    onConfirm: () async {
                      await clearUserSession();
                      await googleSignOut();
                      currentPage.value = 0;
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninPage()),
                            (Route<dynamic> route) => false);
                      }
                    });
              },
              leading: const Icon(Icons.logout),
              title: 'Log Out',
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )),
        ],
      ),
    );
  }
}
