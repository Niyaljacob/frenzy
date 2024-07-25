import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:frenzy/utils/constance.dart';

Widget buildOtpTextField({
  required BuildContext context,
  required TextEditingController controller,
  VoidCallback? validator,
}) {
  return OtpTextField(
    numberOfFields: 4,
    borderColor: primary,
    showFieldAsBox: false,
    fieldWidth: 50.0,
    margin: const EdgeInsets.symmetric(horizontal: 8.0), 
    onCodeChanged: (String code) {
      // handle validation or checks here
      if (validator != null) {
        validator();
      }
    },
     onSubmit: (String verificationCode) {
      controller.text = verificationCode; // Set the controller text to the OTP value
      debugPrint('OTP Entered: $verificationCode'); // Debug print to check the OTP value
    },
  );
}
