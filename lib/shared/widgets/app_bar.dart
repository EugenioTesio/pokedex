import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/sizes.dart';
import 'package:pokedex/features/dark_mode/presentation/widgets/dark_mode_switch.dart';
import 'package:pokedex/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokedex/shared/widgets/app_text.dart';

class PokedexAppBar extends ConsumerWidget {
  const PokedexAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: const Row(
        children: [
          AppText('Pokedex'),
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
      bottom: AppBar(
        title: SizedBox(
          width: double.infinity,
          height: 40,
          child: Center(
            child: TextField(
              controller: ref.watch(pokemonListSearchControllerProvider),
              decoration: const InputDecoration(
                hintText: 'Search for something',
                suffixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
