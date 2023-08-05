// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';

class PokemonState extends Equatable {
  const PokemonState({
    required this.pokemonListItems,
    this.page = 0,
  });

  factory PokemonState.initial() {
    return const PokemonState(pokemonListItems: []);
  }

  final List<PokemonListItem> pokemonListItems;
  final int page;

  @override
  List<Object?> get props => [
        pokemonListItems,
        page,
      ];

  @override
  bool get stringify => true;

  PokemonState copyWith({
    List<PokemonListItem>? pokemonListItems,
    int? page,
  }) {
    return PokemonState(
      pokemonListItems: pokemonListItems ?? this.pokemonListItems,
      page: page ?? this.page,
    );
  }
}
