import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/validation.dart';
import 'package:frenzy/views/bloc/signin/bloc/signin_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/class_widgets/textfield.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/login_to_signup_text.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/first_page/bottom_nav_first_page.dart';
import 'package:frenzy/views/pages/signin_page/forgotpassword/forgot_password_screen.dart';
import 'package:frenzy/views/pages/signup/signup_screen.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:BlocConsumer<SigninBloc, SigninState>(
        listener:(context, state) {
          if(state is SigninSuccesState){
            customSnackbar(context, "Welcome back", primary);
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
              return BottomNavFirstPage();
            }), (Route<dynamic>route)=>false);
          }else if(state is SigninErrorState){
            customSnackbar(context, state.error, red);
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                    const Row(
                      children: [
                        loginText,
                      ],
                    ),
                    kheight40,
                    CustomTextField(
                      hintText: 'email id',
                      validator: validateUsername,
                      controller: _userNameController,
                    ),
                    kheight20,
                    PasswordTextFieldState(
                      hintText: 'password',
                      controller: _passwordController,
                      validator: validatePassword,
                      ),
                    kheight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: forgot,
                        ),
                      ],
                    ),
                    BlocBuilder<SigninBloc, SigninState>(
                      builder: (context, state) {
                        if(state is SigninLoadingState){
                          return loadingAnimationWidget();
                        }
                        return CustomButton(
                      media: MediaQuery.of(context).size,
                      buttonText: "Login",
                      onPressed: () async{
                       if(_formKey.currentState!.validate()){
                        context.read<SigninBloc>().add(
                          OnSigninButtonClickedEvent(
                            email: _userNameController.text, 
                            passowrd: _passwordController.text)
                        );
                       }else{
                        customSnackbar(context, 'Fill All Fields', primary);
                       }
                      },
                      color: primary,
                    );
                      }),
                    
                    kheight,
                    const Text('or'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                          child: Image.asset(google),
                        ),
                        Flexible(child: BlocBuilder<SigninBloc, SigninState>(
                          builder: (context, state) {
                            if (state is GoogleAuthLoadingstate) {
                                return const CircularProgressIndicator();
                              }
                              return TextButton(onPressed: ()async{
                                context.read<SigninBloc>().add(OnGoogleSignInButtonClickedEvent());
                              }, child:  Text('Sign In With Google?',
                                      style: TextStyle(color: Theme.of(context).brightness==Brightness.light? primary:whiteColor)));
                          },
                        ))
                      ],
                    ),
                    loginAndSignUpRow(
                      context: context,
                      preText: 'New User? Join Us Today! ',
                      buttonText: 'Register here',
                      onPressed: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupScreen()));
                      },
                    ),
                  ],
                ),
              ),
            )),
      ));
        },
      )
    );
  }
}
