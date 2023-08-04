import 'package:json_annotation/json_annotation.dart';

part 'pokemon_details.g.dart';

@JsonSerializable()
class PokemonDetailsDto {
  PokemonDetailsDto({
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.name,
    required this.order,
    required this.sprites,
    required this.types,
    required this.weight,
  });
  final List<PokemonAbilityDto> abilities;
  final int baseExperience;
  final int height;
  final int id;
  final String name;
  final int order;
  final PokemonSpritesDto sprites;
  final List<PokemonTypesDto> types;
  final int weight;
}

@JsonSerializable()
class PokemonAbilitiesDto {
  PokemonAbilitiesDto({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });
  final PokemonAbilityDto ability;
  final bool isHidden;
  final int slot;
}

@JsonSerializable()
class PokemonAbilityDto {
  PokemonAbilityDto({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;
}

@JsonSerializable()
class PokemonTypesDto {
  PokemonTypesDto({
    required this.slot,
    required this.type,
  });
  final int slot;
  final PokemonTypeDto type;
}

@JsonSerializable()
class PokemonSpritesDto {
  PokemonSpritesDto({
    required this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
}

@JsonSerializable()
class PokemonTypeDto {
  PokemonTypeDto({
    required this.name,
    required this.url,
  });
  final String name;
  final String url;
}
