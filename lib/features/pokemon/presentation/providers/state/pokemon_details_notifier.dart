import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/get_pokemon_details.dart';
import 'package:pokedex/features/pokemon/presentation/providers/state/pokemon_details_state.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';
import 'package:pokedex/shared/image_cacher/domain/repositories/image_cacher_repository.dart';

class PokemonDetailsStateNotifier
    extends StateNotifier<AsyncValue<PokemonDetailsState>> {
  PokemonDetailsStateNotifier({
    required this.getPokemonDetailsUseCase,
    required this.imageCacherRepository,
  }) : super(const AsyncLoading());

  final GetPokemonDetails getPokemonDetailsUseCase;
  final ImageCacherRepository imageCacherRepository;

  void init(String name) {
    getPokemonDetails(name);
  }

  Future<void> getPokemonDetails(String name) async {
    final failureOrPokemonDetails = await getPokemonDetailsUseCase.call(name);
    if (failureOrPokemonDetails.$1 != null) {
      final imageCacher = await imageCacherRepository.loadImage(
        key: failureOrPokemonDetails.$1!.name,
      );
      state = AsyncData(
        PokemonDetailsState(
          pokemonDetails: failureOrPokemonDetails.$1,
          imageCacher: imageCacher,
        ),
      );
    } else {
      state = AsyncError(
        failureOrPokemonDetails.$2!,
        StackTrace.current,
      );
    }
  }

  Future<void> saveImage(String name, Uint8List imageBytes) async {
    final stateBackup = state.value?.copyWith();
    state = const AsyncLoading();
    await imageCacherRepository.saveImage(
      name,
      imageBytes,
    );
    state = AsyncData(
      stateBackup!.copyWith(
        imageCacher: ImageCacher(
          imageBytes: imageBytes,
          key: name,
          lastModified: DateTime.now(),
        ),
      ),
    );
  }
}
