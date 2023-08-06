import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageProgress extends StatelessWidget {
  const ShimmerImageProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: const SizedBox.expand(
        child: Icon(Icons.image),
      ),
    );
  }
}
