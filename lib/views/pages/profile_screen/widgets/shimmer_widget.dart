import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:shimmer/shimmer.dart';

Widget profileImageShimmerContainer(BuildContext context) {
  double containerHeight = 210;
  double containerWidth = MediaQuery.of(context).size.width;
  double profileImageSize = 180;
  double profileImageOffset = -60;
  Color backgroundColor = Colors.white;

  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Image Shimmer
          Container(
            height: containerHeight,
            width: containerWidth,
            color: Colors.grey[400], // Background shimmer color
          ),
          // Positioned Profile Image Shimmer
          Positioned(
            bottom: profileImageOffset,
            left: 20,
            child: Container(
              height: profileImageSize,
              width: profileImageSize,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(width: 5, color: backgroundColor),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                height: profileImageSize,
                width: profileImageSize,
                decoration: BoxDecoration(
                  color: Colors.grey[400], // Profile image shimmer color
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


Widget shimmerWidget1(Size media) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: media.height * 0.08,
              width: media.height * 0.08,
              color: whiteColor,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: media.width * 0.5,
                  height: 10,
                  color: whiteColor,
                ),
                const SizedBox(height: 5),
                Container(
                  width: media.width * 0.3,
                  height: 10,
                  color: whiteColor,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: media.width,
          height: media.width * 0.5,
          color: whiteColor,
        ),
        const SizedBox(height: 10),
        Container(
          width: media.width * 0.7,
          height: 10,
          color: whiteColor,
        ),
        const SizedBox(height: 10),
        Container(
          width: media.width * 0.9,
          height: 10,
          color: whiteColor,
        ),
      ],
    ),
  );
}