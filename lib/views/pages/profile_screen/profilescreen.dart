import 'package:flutter/material.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
import 'package:frenzy/utils/functions/sigin_with_google.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/confirmationdialog.dart';
import 'package:frenzy/views/pages/first_page/bottom_nav_first_page.dart';
import 'package:frenzy/views/pages/profile_screen/widgets/settings_list_tile.dart';
import 'package:frenzy/views/pages/signin_page/signin.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: settingsListTile(
          onTap: ()async{
            confirmationDialog(
              context: context, 
              title: 'Log Out!', 
              content: "Are you sure ?", 
              confirmButtonText: "confirm", 
              cancelButtonText: "cancel", 
              onConfirm: ()async{
                await clearUserSession();
                await googleSignOut();
                currentPage.value=0;
                if(context.mounted){
                  Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(
                      builder: (context)=> SigninPage()), (Route<dynamic>route)=>false);
                }
              });
          }, 
          leading: const Icon(Icons.logout), 
          title: 'Log Out', 
          trailing: const Icon(Icons.arrow_forward_ios, size: 20,)),
      ),
    );
  }
}