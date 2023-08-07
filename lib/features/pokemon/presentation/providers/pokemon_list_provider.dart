import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/providers/pokemon_providers.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_list_notifier.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_list_state.dart';

final poekmonListStateNotifierProvider =
    StateNotifierProvider<PokemonNotifier, AsyncValue<PokemonState>>((ref) {
  final getPockemonsPage = ref.watch(fetchPokemonPageProvider);
  final fetchPockemonsPageDetails = ref.watch(fetchPokemonsDetailsProvider);
  return PokemonNotifier(
    fetchPokemonPageUseCase: getPockemonsPage,
    fetchPokemonDetailsUseCase: fetchPockemonsPageDetails,
  )..init();
});
