import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/routing/app_router.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/presentation/providers/pokemon_providers.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_list_state.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/pokemon_sliver_list.dart';
import 'package:pokedex/shared/widgets/app_bar.dart';
import 'package:pokedex/shared/widgets/app_text.dart';
import 'package:pokedex/shared/widgets/responsive.dart';

// ignore: comment_references
/// Unique screen that displays a list of [PokemonListItem]s.
class PokemonListScreen extends ConsumerWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<PokemonListState>>(
      poekmonListStateNotifierProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) {
          // show snackbar if an error occurred
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: AppText(error.toString())),
          );
        },
      ),
    );

    final pokemonNotifier = ref.read(poekmonListStateNotifierProvider.notifier);
    final poekmonState = ref.watch(poekmonListStateNotifierProvider);
    final columns = Responsive.isMobile(context)
        ? 1
        : Responsive.isTablet(context)
            ? 2
            : 3;
    if (poekmonState is AsyncData<PokemonListState>) {
      final pokemonList = poekmonState.value.pokemonListItems;
      return PokemonListView(
        pokemonList: pokemonList,
        resultsCount: poekmonState.value.count,
        onLastIndexFetched: pokemonNotifier.fetchPokemons,
        isLoadingMoreResults: poekmonState.value.isLoadingMoreResults,
        columns: columns,
        onItemBuilt: (index) {
          pokemonNotifier.fetchPokemonDetails(
            pokemonList[index].name,
          );
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
class PokemonListView extends StatelessWidget {
  const PokemonListView({
    required this.pokemonList,
    required this.resultsCount,
    this.isLoadingMoreResults = false,
    this.onTap,
    this.onLastIndexFetched,
    this.onItemBuilt,
    this.columns = 1,
    super.key,
  });

  final List<PokemonListItem> pokemonList;
  final Function(PokemonListItem)? onTap;
  final Function()? onLastIndexFetched;
  final Function(int index)? onItemBuilt;
  final int resultsCount;
  final bool isLoadingMoreResults;
  final int columns;

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
          columns: columns,
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
