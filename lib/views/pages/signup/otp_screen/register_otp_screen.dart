

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/model/user_model.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/bloc/signup/otpverification_register/bloc/otp_verification_bloc.dart';
import 'package:frenzy/views/bloc/signup/signup_bloc/sign_up_bloc.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/snackbarcustom.dart';
import 'package:frenzy/views/pages/signin_page/signin.dart';
import 'package:frenzy/views/pages/signup/otp_screen/widgets/otp_field.dart';


class RegisterOtpScreen extends StatefulWidget {
  final UserModel user;
  final String email;
   
  const RegisterOtpScreen({super.key, required this.user, required this.email});

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  final TextEditingController _otpcontrollers = TextEditingController();
  late Timer _time;
  Timer? _debouncerTime;
  int _start=60;
  bool _isRessendVisible=false;

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

  void startTime(){
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


  void debounceResendOtp(SignUpBloc signUpBloc) {
    if (_debouncerTime?.isActive ?? false) _debouncerTime!.cancel();
    _debouncerTime = Timer(const Duration(seconds: 1), () {
      signUpBloc.add(OnSignupButtonClickedEvent(
          userName: widget.user.userName,
          password: widget.user.password,
          phoneNumber: widget.user.phoneNumber,
          email: widget.user.emailId));
      startTime(); 
    });
  }
      
     bool validateOtp() {
  String otp = _otpcontrollers.text.trim();
  debugPrint('Validating OTP: $otp');
  
  if (otp.isEmpty) {
    debugPrint('OTP is empty');
    return false;
  }
  
  if (otp.length != 4) {
    debugPrint('OTP length is not 4, it is ${otp.length}');
    return false;
  }
  
  if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
    debugPrint('OTP does not match regex');
    return false;
  }
  
  return true;
}
  @override
  Widget build(BuildContext context) {
    final signUpBloc = context.read<SignUpBloc>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
        listener:(context, state) {
          if(state is OtpVerificationSuccessState){
            customSnackbar(context, "OTP verification succes", primary);
            _otpcontrollers.clear();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SigninPage()),
            (Route<dynamic>route)=>false,
            );
          }else if(state is OtpVerificationErroState){
            customSnackbar(context, "Invalid OTP", red);
          }
        },
        builder: (context, state){
          return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              kheight20,
              const Row(
                children: [
                  Text("Verification Code", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                ],
              ),
              kheight20,
              registerotp,
               Image.asset('assets/otp_register1.png',height: 150,width: 150,),
              kheight,
              buildOtpTextField(
                context: context, 
                controller: _otpcontrollers),

              
              kheight20,
              BlocBuilder<OtpVerificationBloc, OtpVerificationState>(
                builder: (context, state){
                  if(state is OtpVerificationLoadinState) {
                    return CustomButton(
                      media: MediaQuery.sizeOf(context), 
                      buttonText: "verify", 
                      onPressed: (){}, 
                      color: primary);
                  }
                  return CustomButton(
                    media: MediaQuery.sizeOf(context), 
                    buttonText: "verify", 
                    onPressed: ()async{
                      if(validateOtp()){
                        String otp= _otpcontrollers.text.trim();
                        debugPrint('Entered OTP: $otp');
                        context.read<OtpVerificationBloc>().add(OnOtpVerifyButtonClicked(
                          otp: otp, email: widget.email));
                          _otpcontrollers.clear();
                      }else{
                        customSnackbar(
                          context, "please enter a valid OTP", red);
                      }
                    }, 
                    color: primary);
                },
              ),
              kheight20,
              _isRessendVisible? 
              TextButton(onPressed: (){
                debounceResendOtp(signUpBloc);
              }, child: const Text("Resend OTP",style:  TextStyle(color: primary, fontSize: 16),))
              :Text('Resend OTP in $_start seconds',
                 style: const TextStyle(color: grey, fontSize: 16),)
            ],
          ),
        ),
      );
        }
      )
    );
  }
}