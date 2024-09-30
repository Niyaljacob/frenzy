import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

Widget customMaterialButton({
  required BuildContext context, // Added context parameter
  required VoidCallback onPressed,
  required String text,
  required Color color,
  required double width,
  required double height,
  required double borderRadius,
  TextStyle? textStyle,
}) {
  
  // final TextStyle defaultTextStyle = TextStyle(
  //   color: Theme.of(context).brightness == Brightness.light ? black : whiteColor,
  // );

  return MaterialButton(
    onPressed: onPressed,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    minWidth: width,
    height: height,
    child: Text(
      text,
      style: TextStyle(color: Theme.of(context).brightness==Brightness.light?whiteColor:black), 
    ),
  );
}
