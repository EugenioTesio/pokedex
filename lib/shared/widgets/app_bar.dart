import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/sizes.dart';
import 'package:pokedex/features/dark_mode/presentation/widgets/dark_mode_switch.dart';

class PokedexAppBar extends ConsumerWidget {
  const PokedexAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.tertiary.withAlpha(40),
      centerTitle: false,
      titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      title: const Row(
        children: [
          Text(
            'Pokedex',
            style: TextStyle(fontFamily: 'Pokemon Solid'),
          ),
        ],
      ),
      actions: const [
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
