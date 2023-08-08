import 'package:flutter/material.dart';

class NoImagePlaceholder extends StatelessWidget {
  const NoImagePlaceholder({
    this.size = 100,
    this.icon = Icons.broken_image,
    super.key,
  });

  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: Theme.of(context).colorScheme.secondary,
      child: Icon(
        icon,
        size: size / 2,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
