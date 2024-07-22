import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/validation.dart';
import 'package:frenzy/views/pages/common_widgets/class_widgets/textfield.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/login_to_signup_text.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.30,
                      child: Image.asset(login),
                    ),
                    Row(
                      children: [
                        loginText,
                      ],
                    ),
                    kheight40,
                    CustomTextField(
                      hintText: 'username',
                      validator: validateUsername,
                      controller: _userNameController,
                    ),
                    kheight20,
                    CustomTextField(
                      hintText: 'password',
                      validator: validateUsername,
                      controller: _passwordController,
                    ),
                    kheight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: forgot,
                        ),
                      ],
                    ),
                    CustomButton(
                      media: MediaQuery.of(context).size,
                      buttonText: "Login",
                      onPressed: () {
                      },
                      color: primary,
                    ),
                    kheight,
                    const Text('or'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                          child:  Image.asset(google),
                          
                        ),
                        const Text('Sign In With Google?',
                        style: TextStyle(color: primary))
                      ],
                    ),
                    loginAndSignUpRow(
                      context: context, 
                      preText: 'New User? Join Us Today! ', 
                      buttonText: 'Register here', 
                      onPressed: ()async{},
                      ),
                      
                  ],
                ),
              ),
            )),
      )),
    );
  }
}
