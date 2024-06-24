import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

final List<String> chipLabels = [
  'Cfs/C++',
  'Darsfst',
  'Javas',
  'JavaScript',
  'PHPsf',
  'Python',
  'Rufby',
  'sssss',
  'TypeScript',
  'Kotlin',
  'Swift'
];

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white54,
      highlightColor: Colors.white,
      child: Wrap(
        children: List.generate(
          10,
          (index) {
            double labelWidth = (chipLabels[index].length * 10).toDouble();
            double itemWidth = Random().nextInt(50).toDouble() + labelWidth + 5;
            double itemHeight = 15.h;
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              margin: EdgeInsets.only(right: 5.w, top: 5.h),
              width: itemWidth.w,
              height: itemHeight.h,
            );
          },
        ),
      ),
    );
  }
}
