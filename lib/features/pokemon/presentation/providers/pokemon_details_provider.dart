import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/providers/pokemon_providers.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_details_notifier.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_details_state.dart';
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
