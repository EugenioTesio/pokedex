import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/providers/pokemon_providers.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_details_notifier.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_details_state.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_list_notifier.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_list_state.dart';
import 'package:pokedex/shared/image_cacher/domain/providers/image_cacher_provider.dart';

final poekmonDetailsStateNotifierProvider = StateNotifierProvider.autoDispose
    .family<PokemonDetailsStateNotifier, AsyncValue<PokemonDetailsState>,
        String>(
  (ref, name) {
    final getPokemonDetails = ref.watch(getPokemonDetailsProvider);
    final fetchPokemonDetails = ref.watch(imageCacherRepositoryProvider);
    return PokemonDetailsStateNotifier(
      getPokemonDetailsUseCase: getPokemonDetails,
      imageCacherRepository: fetchPokemonDetails,
    )..init(name);
  },
);

final poekmonListStateNotifierProvider =
    StateNotifierProvider<PokemonNotifier, AsyncValue<PokemonListState>>((ref) {
  final getPockemonsPage = ref.watch(fetchPokemonPageProvider);
  final fetchPockemonsPageDetails = ref.watch(fetchPokemonsDetailsProvider);
  final searchController = ref.watch(pokemonListSearchControllerProvider);
  return PokemonNotifier(
    fetchPokemonPageUseCase: getPockemonsPage,
    fetchPokemonDetailsUseCase: fetchPockemonsPageDetails,
    searchController: searchController,
  )..init();
});

final pokemonListSearchControllerProvider = Provider<TextEditingController>(
  (ref) => TextEditingController(),
);
