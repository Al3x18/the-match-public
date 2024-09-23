import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer shimmerLoadForMatches({bool isDark = false}) {
  return Shimmer.fromColors(
    baseColor: isDark ? Colors.black45 : Colors.white,
    highlightColor: isDark ? Colors.grey : Colors.transparent,
    child: CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  // Match time placeholder
                  Container(
                    margin: const EdgeInsets.only(left: 6),
                    width: 50,
                    height: 60,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 10),
                  // Match card placeholder
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      height: 60,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
