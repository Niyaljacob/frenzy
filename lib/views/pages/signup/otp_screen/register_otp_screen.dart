

import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/pages/common_widgets/function_widgets/custom_button.dart';
import 'package:frenzy/views/pages/signup/otp_screen/widgets/otp_field.dart';


class RegisterOtpScreen extends StatefulWidget {
   
   RegisterOtpScreen({super.key});

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  final TextEditingController _otpcontrollers = TextEditingController();
      
      
      bool validateOtp() {
    String otp = _otpcontrollers.text;
    if (otp.isEmpty || otp.length != 4 || !RegExp(r'^[0-9]+$').hasMatch(otp)) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              kheight20,
              Row(
                children: [
                  Text("Verification Code", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                ],
              ),
              kheight20,
              registerotp,
               Image.asset('assets/otp_register1.png',height: 150,width: 150,),
              // Lottie.asset('assets/Animation.json'),
              kheight20,
              buildOtpTextField(
                context: context, 
                controller: _otpcontrollers,
                validator: validateOtp),
                kheight30,
              CustomButton(
                media: MediaQuery.sizeOf(context), 
                buttonText: "Verify", 
                onPressed: (){}, 
                color: primary)
            ],
          ),
        ),
      )
    );
  }
}