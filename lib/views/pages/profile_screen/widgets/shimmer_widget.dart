import 'package:flutter/material.dart';
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
