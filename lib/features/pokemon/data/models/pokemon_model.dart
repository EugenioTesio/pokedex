import 'package:json_annotation/json_annotation.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonListModel extends PokemonList {
  const PokemonListModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });
}

@JsonSerializable()
class PokemonListItemModel extends PokemonListItem {
  const PokemonListItemModel({
    required super.name,
    required super.url,
  });
}
