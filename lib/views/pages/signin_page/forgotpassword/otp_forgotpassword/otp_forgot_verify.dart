import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_bloc.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_event.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_state.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/loading_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/signin_page/signin.dart';
import 'package:frenzy/views/pages/signup/otp_screen/widgets/otp_field.dart';

class OtpForgotVerify extends StatefulWidget {
  final String email;
  const OtpForgotVerify({super.key, required this.email});

  @override
  State<OtpForgotVerify> createState() => _OtpForgotVerifyState();
}

class _OtpForgotVerifyState extends State<OtpForgotVerify> {
  final TextEditingController _otpcontrollers = TextEditingController();
  late Timer _time;
  Timer? _debouncerTime;
  int _start = 60;
  bool _isRessendVisible = false;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    _time.cancel();
    _debouncerTime?.cancel();
    _otpcontrollers.dispose();
    super.dispose();
  }

  void startTime() {
    _isRessendVisible = false;
    _start = 60;
    _time = Timer.periodic(const Duration(seconds: 1), (time) {
      if (_start == 0) {
        setState(() {
          _isRessendVisible = true;
          time.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void debounceResendOtp() {
    if (_debouncerTime?.isActive ?? false) _debouncerTime!.cancel();
    _debouncerTime = Timer(const Duration(seconds: 1), () {
      // Handle resend OTP logic here
      startTime();
    });
  }

  bool validateOtp() {
    String otp = _otpcontrollers.text.trim();
    if (otp.isEmpty) {
      return false;
    }
    if (otp.length != 4) {
      return false;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is OtpverifiedSuccesState) {
            customSnackbar(context, "OTP verification success", primary);
            _otpcontrollers.clear();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SigninPage()),
              (Route<dynamic> route) => false,
            );
          } else if (state is OtpverifiedErrorState) {
            customSnackbar(context, "Invalid OTP", red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  kheight,
                  const 
                      Text("Verification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    
                  
                  kheight30,
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(happyForgot),
                  ),
                  kheight20,
                 forgotpassword3,
                  kheight20,
                  buildOtpTextField(context: context, controller: _otpcontrollers),
                  kheight20,
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      if (state is OtpverifiedLoadingState) {
                        return loadingAnimationWidget();
                      }
                      return CustomButton(
                        media: MediaQuery.sizeOf(context),
                        buttonText: "Verify",
                        onPressed: () async {
                          if (validateOtp()) {
                            String otp = _otpcontrollers.text.trim();
                            context.read<ForgotPasswordBloc>().add(
                              OnVerifyButtonClickedEvent(
                                otp: otp,
                                email: widget.email,
                              ),
                            );
                            _otpcontrollers.clear();
                          } else {
                            customSnackbar(context, "Please enter a valid OTP", red);
                          }
                        },
                        color: primary,
                      );
                    },
                  ),
                  kheight20,
                  _isRessendVisible
                      ? TextButton(
                          onPressed: () {
                            debounceResendOtp();
                          },
                          child: const Text("Resend OTP", style: TextStyle(color: primary, fontSize: 16)),
                        )
                      : Text('Resend OTP in $_start seconds', style: const TextStyle(color: grey, fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
