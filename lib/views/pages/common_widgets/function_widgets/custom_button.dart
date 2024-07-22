import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

class CustomButton extends StatelessWidget {
  final Size media;
  final String buttonText;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    required this.media,
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: media.width,
      height: media.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
           
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(buttonText, style: TextStyle(color: whiteColor)),
      ),
    );
  }
}
