

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:frenzy/views/pages/home/suggestion/suggestion.dart';

class Richtext extends StatelessWidget {
  const Richtext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(
            text: 'Go to  ',
            style: TextStyle(
                color: black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15)),
        TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigatePushAnimaterbottomtotop(
                    context, const SuggestionPage());
              },
            text: 'Suggessions?',
            style: const TextStyle(
                color: primary,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15))
      ]),
    );
  }
  
  void navigatePushAnimaterbottomtotop(BuildContext context, suggessionScreen) {}
}
