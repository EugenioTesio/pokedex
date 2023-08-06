import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/routing/app_router.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/presentation/providers/pokemon_state_notifier_provider.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_state.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_silver_list.dart';
import 'package:pokedex/shared/widgets/app_text.dart';

// ignore: comment_references
/// Desktop view of the [PokemonListScreen] witch contains the state management
class PokemonListDesktop extends ConsumerStatefulWidget {
  const PokemonListDesktop({super.key});

  @override
  ConsumerState<PokemonListDesktop> createState() => _PokemonListDesktopState();
}

class _PokemonListDesktopState extends ConsumerState<PokemonListDesktop> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => ref.read(poekmonStateNotifierProvider.notifier).getPokemonList(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<PokemonState>>(
      poekmonStateNotifierProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          // show snackbar if an error occurred
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: AppText(error.toString())),
          );
        },
      ),
    );

    final poekmonState = ref.watch(poekmonStateNotifierProvider);
    if (poekmonState is AsyncData<PokemonState>) {
      final pokemonList = poekmonState.value.pokemonListItems;
      return PokemonListDesktopView(
        pokemonList: pokemonList,
        onTap: (pokemonListItem) {
          context.goNamed(
            AppRoute.pokemonDetails.name,
            pathParameters: {
              'name': pokemonListItem.name,
            },
          );
        },
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

/// Raw widget that displays a list of [PokemonListItem]s.
class PokemonListDesktopView extends StatelessWidget {
  const PokemonListDesktopView({
    required this.pokemonList,
    this.onTap,
    super.key,
  });

  final List<PokemonListItem> pokemonList;
  final Function(PokemonListItem)? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PokemonSilverList(
              children: pokemonList
                  .map<Widget>(
                    (e) => PokemonListItemCard(
                      pokemonListItem: e,
                      onTap: onTap,
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
