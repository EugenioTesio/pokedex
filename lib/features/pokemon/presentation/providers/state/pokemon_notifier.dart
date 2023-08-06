import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/get_pokemons_page.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_state.dart';

class PokemonNotifier extends StateNotifier<AsyncValue<PokemonState>> {
  PokemonNotifier({
    required this.getPockemonsPage,
  }) : super(AsyncData<PokemonState>(PokemonState.initial()));

  final GetPokemonsPage getPockemonsPage;

  int page = 1;

  Future<void> getPokemonList() async {
    state = const AsyncLoading();
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
        ),
      );
    } else {
      state = AsyncError(
        failureOrPokemonList.$2!,
        StackTrace.current,
      );
    }
  }
}
