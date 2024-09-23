import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer shimmerForStandings({bool isDark = false}) {
  return Shimmer.fromColors(
    baseColor: isDark ? Colors.black45 : Colors.white,
    highlightColor: isDark ? Colors.grey : Colors.transparent,
    child: CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.5),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                height: 20,
                width: double.infinity,
                color: Colors.white,
              ),
            );
          },
        ),
      ],
    ),
  );
}
