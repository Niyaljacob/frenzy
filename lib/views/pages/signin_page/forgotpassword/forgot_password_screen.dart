import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/utils/validation.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_bloc.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_event.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_state.dart';
import 'package:frenzy/views/pages/common_widgets/class_widgets/textfield.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/signin_page/forgotpassword/otp_forgotpassword/otp_forgotpassword_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});

    final TextEditingController _emailController = TextEditingController();
    final _formKey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        elevation: 0,
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if(state is ForgotPasswordSuccesState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpForgotpasswordScreen(
              email:_emailController.text,
            )));
          }else if(state is ForgotPasswordErrorState){
            customSnackbar(context, state.error, red);
          }
        },
        builder:(context, state) {
          return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const Center(child: forgotpassword),

               const Image(image: AssetImage(sadForgot),height: 200,),
               kheight20,
               forgotpassword1,
               kheight15,
               forgotpassword2,
               kheight40,
               Form(
                key: _formKey,
                child: ForgotCustomTextField(
                  hintText: 'Enter the email', 
                  controller: _emailController, 
                  validator: validateEmail)),
                  kheight40,

                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder:(context, state) {
                      if(state is ForgotPasswordLoadingState){
                        return CustomButton(
                          media: MediaQuery.sizeOf(context), 
                          buttonText: "Send", onPressed: (){}, color: primary);
                      }
                      return CustomButton(
                    media: MediaQuery.of(context).size,
                    buttonText: 'Send', 
                    onPressed: (){
                      if(_formKey.currentState?.validate()==true){
                        context.read<ForgotPasswordBloc>().add(
                          OnForgotPassLoginButtonClicked(
                            email: _emailController.text)
                        );
                      }
                    }, 
                    color: primary);
                    },)
                  
            ],),
         
        ),
      );
        },
      )
    );
  }
}



