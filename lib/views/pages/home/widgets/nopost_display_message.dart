import 'package:flutter/material.dart';
import 'package:frenzy/views/pages/home/suggestion/suggestion.dart';

Widget noFeedAvailableMessage(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No feed available!',
          style: TextStyle(),
        ),
        const SizedBox(height: 10),
        const Text(
          'Follow someone to see their posts or explore suggestions.',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SuggestionPage(),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Go to Suggestions?'),
        ),
      ],
    ),
  );
}