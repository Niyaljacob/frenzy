import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

class SearchFormFieldExplore extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  final Function(String) onTextChanged;

  const SearchFormFieldExplore({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboard,
    this.validator, required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onTextChanged,
      validator: validator,
      cursorWidth: 2,
      controller: controller,
      keyboardType: keyboard,
      cursorColor: black,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: grey,
        ),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: primary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: grey),
        ),
      ),
    );
  }
}
