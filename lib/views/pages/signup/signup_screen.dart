import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/user_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/validation.dart';
import 'package:frenzy/views/bloc/signup/signup_bloc/sign_up_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/class_widgets/textfield.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/login_to_signup_text.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/signin_page/signin.dart';
import 'package:frenzy/views/pages/signup/otp_screen/register_otp_screen.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey=GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state){
            if(state is SignUpLoadingState){
              customSnackbar(context, 'Succes', primary);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx)=>RegisterOtpScreen(
                  email: _emailController.text,
                      user: UserModel(
                          userName: _userNameController.text,
                          password: _passwordController.text,
                          phoneNumber: _phoneController.text,
                          emailId: _emailController.text),
                )
                )
                );
            }else if (state is signUpErrorState){
              customSnackbar(context, state.error, red);
            }
          },
          builder: (context, state){
            return SafeArea(
              child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.15,
                      child:  Image.asset( Theme.of(context).brightness == Brightness.light
                    ? singupdark
                    : singuplight,),
                      ),
                      kheight,
                      singupText,
                      kheight30,
                      CustomTextField(
                        hintText: 'Username', 
                        controller: _userNameController,
                        validator: validateUsername,),
                        kheight20,
                      CustomTextField(
                        hintText: "Email", 
                        controller: _emailController,
                        validator: validateEmail,),
                        kheight20,
                      CustomTextField(
                        hintText: "Phone No", 
                        controller: _phoneController,
                        validator: validateMobileNumber,),
                        kheight20,
                      PasswordTextFieldState(
                        hintText: "password",
                        validator: validatePassword,
                        controller: _passwordController,),
                        kheight20,
                      PasswordTextFieldState(
                        hintText: "Confirm Password",
                        validator: validatePassword,
                        controller: _confirmPasswordController,),
                        kheight20,
                       BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state){
                          if(state is SignUpLoadingState){
                            return CustomButton(
                              media: MediaQuery.sizeOf(context), 
                              buttonText: 'Register',
                              onPressed: (){}, color: primary);
                          }
                          return CustomButton(
                            media: MediaQuery.sizeOf(context), 
                            buttonText: 'Register', 
                            onPressed: ()async{
                              if(_passwordController.text==_confirmPasswordController.text){
                                if(_formKey.currentState!.validate()){
                                  context.read<SignUpBloc>().add(
                                    OnSignupButtonClickedEvent(
                                      userName: _userNameController.text, 
                                      password: _passwordController.text, 
                                      phoneNumber: _phoneController.text, 
                                      email: _emailController.text)
                                  );
                                }else{
                                  customSnackbar(context, 'Fill all Fields', red);
                                }
                              }else{
                                customSnackbar(context, "Password miss match", red);
                              }
                            }, 
                            color: primary);
                        },
                       ),
                        kheight15,
                        loginAndSignUpRow(
                          context: context, 
                          preText: "Already have an account?", 
                          buttonText: 'LogIn Now', 
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage()));
                          })
                    ],
                  )),
              ),
                        ),
            );
          },
        )
        
    );
  }
}