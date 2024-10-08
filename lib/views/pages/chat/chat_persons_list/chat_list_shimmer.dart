import 'package:flutter/material.dart';
import 'package:frenzy/utils/constance.dart';
import 'package:shimmer/shimmer.dart';

Shimmer messageScreenShimmerLoading() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ttb,
    highlightColor: Colors.grey.shade100,
    baseColor: Colors.grey.shade300,
    child: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: whiteColor,
                        radius: 28,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: whiteColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: whiteColor),
                          ),
                          kheight,
                          Container(
                            height: 10,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: whiteColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: whiteColor),
                        height: 15,
                        width: 40,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    ),
  );
}
