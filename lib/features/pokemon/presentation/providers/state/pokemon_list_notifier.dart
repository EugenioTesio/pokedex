import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/fetch_pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/fetch_pokemon_page.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_list_state.dart';

class PokemonNotifier extends StateNotifier<AsyncValue<PokemonListState>> {
  PokemonNotifier({
    required this.fetchPokemonPageUseCase,
    required this.fetchPokemonDetailsUseCase,
    required this.searchController,
  }) : super(AsyncData<PokemonListState>(PokemonListState.initial()));

  final FetchPokemonPage fetchPokemonPageUseCase;
  final FetchPokemonDetails fetchPokemonDetailsUseCase;
  final TextEditingController searchController;

  int page = 1;

  String searchFilterText = '';
  List<PokemonListItem> pokemonListItems = [];

  void init() {
    // Listen to the search filter controller and filter the pokemon list items.
    searchController.addListener(() {
      searchFilterText = searchController.text;
      if (searchFilterText != '') {
        final filteredItems = pokemonListItems.where((item) {
          return item.name.contains(searchFilterText);
        }).toList();
        state = AsyncData(
          state.value!.copyWith(
            pokemonListItems: filteredItems,
          ),
        );
      } else {
        state = AsyncData(
          state.value!.copyWith(
            pokemonListItems: pokemonListItems,
          ),
        );
      }
    });
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    // Avoid fetching pokemons if the search filter is not empty.
    if (searchFilterText != '') {
      return;
    }

    if (page == 1) {
      state = const AsyncLoading();
    } else {
      await Future.delayed(const Duration(seconds: 1));
      state = AsyncData(
        state.value!.copyWith(isLoadingMoreResults: true),
      );
    }

    final failureOrPokemonList = await fetchPokemonPageUseCase.call(page);

    if (failureOrPokemonList.$1 != null) {
      final newItems = failureOrPokemonList.$1!.results;
      pokemonListItems.addAll(newItems);
      page++;
      state = AsyncData(
        PokemonListState(
          pokemonListItems: pokemonListItems,
          page: page,
          count: failureOrPokemonList.$1!.count,
        ),
      );
    } else {
      state = AsyncData(
        state.value!.copyWith(isLoadingMoreResults: false),
      );
      state = AsyncError(
        failureOrPokemonList.$2!,
        StackTrace.current,
      );
    }
  }

  /// Fetch pokemon details by name while user is scrolling the list.
  Future<void> fetchPokemonDetails(String name) async {
    // Avoid fetching pokemons if the search filter is not empty.
    if (searchFilterText != '') {
      return;
    }
    await fetchPokemonDetailsUseCase.call(name);
  }
}
