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


class PasswordTextFieldState extends StatefulWidget {
  const PasswordTextFieldState({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.margin,
    this.keyboardType,
    // this.obscureText = false,
    this.validator,
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  // final bool obscureText;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordTextFieldState> createState() => _PasswordTextFieldState();
}

bool isObsecure = true;

class _PasswordTextFieldState extends State<PasswordTextFieldState> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(0),
      child: StatefulBuilder(
        builder: (context, setState) {
          // bool isObscure = isObsecure;
          return TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: isObsecure,
            validator: widget.validator,
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
              suffixIcon: IconButton(
                icon: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: whiteColor, width: 2.0),
                borderRadius: radius10,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: primary, width: 2.0),
                borderRadius: radius10,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: radius10,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.redAccent, width: 2.0),
                borderRadius: radius10,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ForgotCustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const ForgotCustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}