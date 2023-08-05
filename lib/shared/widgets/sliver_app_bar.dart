import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/shared/widgets/app_bar.dart';

class PokedexSliverAppBar extends ConsumerWidget {
  const PokedexSliverAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPersistentHeader(
      delegate: _AppBarDelegate(),
      floating: true,
    );
  }
}

class _AppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return const PokedexAppBar();
  }

  @override
  double get minExtent => 56;

  @override
  double get maxExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
