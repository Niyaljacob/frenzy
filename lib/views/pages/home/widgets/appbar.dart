import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.16,
      decoration: const BoxDecoration(
        color: whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 125,
              child: Image.asset(
                  Theme.of(context).brightness == Brightness.light
                      ? singupdark
                      : singuplight),
            ),
            const Icon(
              Icons.person_search_outlined,
              size: 35,
              color: primary,
            )
          ],
        ),
      ),
    );
  }
}
