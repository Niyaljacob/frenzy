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
import 'package:frenzy/views/pages/signin_page/forgotpassword/otp_forgotpassword/otp_forgot_verify.dart';


class OtpForgotpasswordScreen extends StatelessWidget {
  final String email;
  OtpForgotpasswordScreen({super.key, required this.email});

  final TextEditingController _newPassWordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Password Reset',
            style: TextStyle(color: primary, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                    child: Image.asset(login),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: size.height * 0.4,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            hintText: 'Enter new Password',
                            controller: _newPassWordController,
                            validator: validatePassword,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Re-enter new password',
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _newPassWordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 50),
                          BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                            builder: (context, state) {
                              if (state is ResetPasswordLoadingState) {
                                return CustomButton(
                                  media: MediaQuery.sizeOf(context),
                                  buttonText: 'Saving...',
                                  onPressed: () {},
                                  color: primary,
                                );
                              }
                              return CustomButton(
                                media: MediaQuery.sizeOf(context),
                                buttonText: 'Save',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ForgotPasswordBloc>().add(
                                      OnResetPasswordButtonClickedEvent(
                                        email: email,
                                        password: _confirmPasswordController.text,
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OtpForgotVerify(email: email),
                                      ),
                                    );
                                  } else {
                                    customSnackbar(context, 'Please fix the errors', red);
                                  }
                                },
                                color: primary,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
