import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/get_pokemons_page.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_state.dart';

class PokemonNotifier extends StateNotifier<AsyncValue<PokemonState>> {
  PokemonNotifier({
    required this.getPockemonsPage,
  }) : super(AsyncData<PokemonState>(PokemonState.initial()));

  final GetPokemonsPage getPockemonsPage;

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

    final failureOrPokemonList = await getPockemonsPage.call(page);

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
}
