import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/fetch_pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/fetch_pokemon_page.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_list_state.dart';

class PokemonNotifier extends StateNotifier<AsyncValue<PokemonState>> {
  PokemonNotifier({
    required this.fetchPokemonPageUseCase,
    required this.fetchPokemonDetailsUseCase,
  }) : super(AsyncData<PokemonState>(PokemonState.initial()));

  final FetchPokemonPage fetchPokemonPageUseCase;
  final FetchPokemonDetails fetchPokemonDetailsUseCase;

  int page = 1;

  void init() {
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
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
      final oldItems = state.value?.pokemonListItems ?? [];
      final newItems = failureOrPokemonList.$1!.results;
      page++;
      state = AsyncData(
        PokemonState(
          pokemonListItems: [
            ...oldItems,
            ...newItems,
          ],
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
    await fetchPokemonDetailsUseCase.call(name);
  }
}
