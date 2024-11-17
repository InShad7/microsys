import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/colors.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(7),
        height: width / 6,
        decoration: BoxDecoration(
          color: blue2,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
