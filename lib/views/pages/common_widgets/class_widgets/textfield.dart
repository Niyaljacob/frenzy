import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.icon,
      required this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.minlines,
      this.rightIcon,
      this.maxlines,
      this.validator});
  final int? minlines;
  final int? maxlines;
  final TextEditingController controller;
  final String hintText;
  final String? icon;
  final Widget? rightIcon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: maxlines,
        controller: controller,
        minLines: minlines,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: whiteColor, width: 2.0),
              borderRadius: radius10),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primary, width: 2.0),
              borderRadius: radius10),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: radius10),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
              borderRadius: radius10),
        ));
  }
}