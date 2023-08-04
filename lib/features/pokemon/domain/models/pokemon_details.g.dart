// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetailsDto _$PokemonDetailsDtoFromJson(Map<String, dynamic> json) =>
    PokemonDetailsDto(
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => PokemonAbilityDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseExperience: json['baseExperience'] as int,
      height: json['height'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      order: json['order'] as int,
      sprites:
          PokemonSpritesDto.fromJson(json['sprites'] as Map<String, dynamic>),
      types: (json['types'] as List<dynamic>)
          .map((e) => PokemonTypesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      weight: json['weight'] as int,
    );

Map<String, dynamic> _$PokemonDetailsDtoToJson(PokemonDetailsDto instance) =>
    <String, dynamic>{
      'abilities': instance.abilities,
      'baseExperience': instance.baseExperience,
      'height': instance.height,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'sprites': instance.sprites,
      'types': instance.types,
      'weight': instance.weight,
    };

PokemonAbilitiesDto _$PokemonAbilitiesDtoFromJson(Map<String, dynamic> json) =>
    PokemonAbilitiesDto(
      ability:
          PokemonAbilityDto.fromJson(json['ability'] as Map<String, dynamic>),
      isHidden: json['isHidden'] as bool,
      slot: json['slot'] as int,
    );

Map<String, dynamic> _$PokemonAbilitiesDtoToJson(
        PokemonAbilitiesDto instance) =>
    <String, dynamic>{
      'ability': instance.ability,
      'isHidden': instance.isHidden,
      'slot': instance.slot,
    };

PokemonAbilityDto _$PokemonAbilityDtoFromJson(Map<String, dynamic> json) =>
    PokemonAbilityDto(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PokemonAbilityDtoToJson(PokemonAbilityDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

PokemonTypesDto _$PokemonTypesDtoFromJson(Map<String, dynamic> json) =>
    PokemonTypesDto(
      slot: json['slot'] as int,
      type: PokemonTypeDto.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonTypesDtoToJson(PokemonTypesDto instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type,
    };

PokemonSpritesDto _$PokemonSpritesDtoFromJson(Map<String, dynamic> json) =>
    PokemonSpritesDto(
      backDefault: json['backDefault'] as String?,
      backFemale: json['backFemale'] as String?,
      backShiny: json['backShiny'] as String?,
      backShinyFemale: json['backShinyFemale'] as String?,
      frontDefault: json['frontDefault'] as String?,
      frontFemale: json['frontFemale'] as String?,
      frontShiny: json['frontShiny'] as String?,
      frontShinyFemale: json['frontShinyFemale'] as String?,
    );

Map<String, dynamic> _$PokemonSpritesDtoToJson(PokemonSpritesDto instance) =>
    <String, dynamic>{
      'backDefault': instance.backDefault,
      'backFemale': instance.backFemale,
      'backShiny': instance.backShiny,
      'backShinyFemale': instance.backShinyFemale,
      'frontDefault': instance.frontDefault,
      'frontFemale': instance.frontFemale,
      'frontShiny': instance.frontShiny,
      'frontShinyFemale': instance.frontShinyFemale,
    };

PokemonTypeDto _$PokemonTypeDtoFromJson(Map<String, dynamic> json) =>
    PokemonTypeDto(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PokemonTypeDtoToJson(PokemonTypeDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
