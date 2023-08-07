import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageProgress extends StatelessWidget {
  const ShimmerImageProgress({
    required this.size,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: SizedBox.expand(
        child: Icon(
          Icons.image,
          size: size,
        ),
      ),
    );
  }
}
