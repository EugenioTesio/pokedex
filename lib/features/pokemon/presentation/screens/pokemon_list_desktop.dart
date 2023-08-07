import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/routing/app_router.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/presentation/providers/pokemon_state_notifier_provider.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_state.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_sliver_list.dart';
import 'package:pokedex/shared/widgets/app_bar.dart';
import 'package:pokedex/shared/widgets/app_text.dart';

// ignore: comment_references
/// Desktop view of the [PokemonListScreen] witch contains the state management
class PokemonListDesktop extends ConsumerWidget {
  const PokemonListDesktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNotifier = ref.read(poekmonStateNotifierProvider.notifier);
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
        resultsCount: poekmonState.value.count,
        onLastIndexFetched: pokemonNotifier.fetchPokemons,
        isLoadingMoreResults: poekmonState.value.isLoadingMoreResults,
        onItemBuilt: (index) {
          pokemonNotifier.getPokemonDetails(pokemonList[index].name);
        },
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

/// Raw widget that displays a list of [PokemonListItem]s. Nethier this widget
/// nor its children should have any business logic.
class PokemonListDesktopView extends StatelessWidget {
  const PokemonListDesktopView({
    required this.pokemonList,
    required this.resultsCount,
    this.isLoadingMoreResults = false,
    this.onTap,
    this.onLastIndexFetched,
    this.onItemBuilt,
    super.key,
  });

  final List<PokemonListItem> pokemonList;
  final Function(PokemonListItem)? onTap;
  final Function()? onLastIndexFetched;
  final Function(int index)? onItemBuilt;
  final int resultsCount;
  final bool isLoadingMoreResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PokemonSliverList(
          sliverAppBar: const PokedexAppBar(),
          resultsCount: resultsCount,
          showLoading: isLoadingMoreResults,
          onLastIndexFetched: onLastIndexFetched,
          onItemBuilt: onItemBuilt,
          children: pokemonList
              .map<Widget>(
                (e) => PokemonListItemCard(
                  pokemonListItem: e,
                  onTap: onTap,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
