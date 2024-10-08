import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

Row loginAndSignUpRow({
  required BuildContext context,
  required String preText,
  required String buttonText,
  required VoidCallback onPressed,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(preText),
      Flexible(
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(color: primary),
          ),
        ),
      ),
    ],
  );
}
