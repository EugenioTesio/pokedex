import 'package:json_annotation/json_annotation.dart';

part 'pokemon_dto.g.dart';

@JsonSerializable()
class PokemonListDto {
  const PokemonListDto({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<PokemonListItemDto> results;
}

@JsonSerializable()
class PokemonListItemDto {
  const PokemonListItemDto({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
}
