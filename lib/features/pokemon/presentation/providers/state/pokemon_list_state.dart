// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';

class PokemonListState extends Equatable {
  const PokemonListState({
    required this.pokemonListItems,
    this.count = 0,
    this.page = 0,
    this.isLoadingMoreResults = false,
  });

  factory PokemonListState.initial() {
    return const PokemonListState(pokemonListItems: []);
  }

  final List<PokemonListItem> pokemonListItems;
  final int page;
  final int count;
  final bool isLoadingMoreResults;

  @override
  List<Object?> get props => [
        pokemonListItems,
        page,
        count,
        isLoadingMoreResults,
      ];

  @override
  bool get stringify => true;

  PokemonListState copyWith({
    List<PokemonListItem>? pokemonListItems,
    int? page,
    int? count,
    bool? isLoadingMoreResults,
  }) {
    return PokemonListState(
      pokemonListItems: pokemonListItems ?? this.pokemonListItems,
      page: page ?? this.page,
      count: count ?? this.count,
      isLoadingMoreResults: isLoadingMoreResults ?? this.isLoadingMoreResults,
    );
  }
}
