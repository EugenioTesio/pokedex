import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/sizes.dart';
import 'package:pokedex/features/dark_mode/presentation/widgets/dark_mode_switch.dart';

class PokedexAppBar extends ConsumerWidget {
  const PokedexAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SliverAppBar(
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          Text(
            'Pokedex',
            style: TextStyle(fontFamily: 'Pokemon Solid'),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            DarkModeSwitch(),
            AppGaps.gapW8,
          ],
        ),
      ],
    );
  }
}
