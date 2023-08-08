import 'package:equatable/equatable.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';

class PokemonDetailsState extends Equatable {
  const PokemonDetailsState({
    this.pokemonDetails,
    this.imageCacher,
  });

  factory PokemonDetailsState.initial() {
    return const PokemonDetailsState();
  }

  final PokemonDetails? pokemonDetails;
  final ImageCacher? imageCacher;

  @override
  List<Object?> get props => [
        pokemonDetails,
        imageCacher,
      ];

  @override
  bool get stringify => true;

  PokemonDetailsState copyWith({
    PokemonDetails? pokemonDetails,
    ImageCacher? imageCacher,
  }) {
    return PokemonDetailsState(
      pokemonDetails: pokemonDetails ?? this.pokemonDetails,
      imageCacher: imageCacher ?? this.imageCacher,
    );
  }
}
