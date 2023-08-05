import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/providers/pokemon_providers.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_notifier.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_state.dart';

final poekmonStateNotifierProvider =
    StateNotifierProvider<PokemonNotifier, AsyncValue<PokemonState>>((ref) {
  final getPockemonsPage = ref.watch(getPokemonsPageProvider);
  return PokemonNotifier(
    getPockemonsPage: getPockemonsPage,
  )..getPokemonList();
});
