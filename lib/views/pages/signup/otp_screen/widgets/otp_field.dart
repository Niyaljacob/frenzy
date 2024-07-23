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
    fieldWidth: 50.0, // Increase the width of each field
    margin: const EdgeInsets.symmetric(horizontal: 8.0), // Add space between fields
    onCodeChanged: (String code) {
      // handle validation or checks here
      if (validator != null) {
        validator();
      }
    },
  );
}
