// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';

part 'pokemon_details_model.g.dart';

@HiveType(typeId: HiveConstants.pokemonDetailsModel)
class PokemonDetailsModel {
  const PokemonDetailsModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.sprites,
    required this.types,
    required this.baseExperience,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int height;
  @HiveField(3)
  final int weight;
  @HiveField(4)
  final List<PokemonAbilitiesModel>? abilities;
  @HiveField(5)
  final PokemonSpritesModel? sprites;
  @HiveField(6)
  final List<PokemonTypesModel>? types;
  @HiveField(7)
  final int baseExperience;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'abilities': abilities?.map((x) => x.toMap()).toList(),
      'sprites': sprites?.toMap(),
      'types': types?.map((x) => x.toMap()).toList(),
      'baseExperience': baseExperience,
    };
  }

  factory PokemonDetailsModel.fromMap(Map<String, dynamic> map) {
    return PokemonDetailsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      height: map['height'] as int,
      weight: map['weight'] as int,
      abilities: map['abilities'] != null
          ? List<PokemonAbilitiesModel>.from(
              (map['abilities'] as List<int>).map<PokemonAbilitiesModel?>(
                (x) => PokemonAbilitiesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      sprites: map['sprites'] != null
          ? PokemonSpritesModel.fromMap(map['sprites'] as Map<String, dynamic>)
          : null,
      types: map['types'] != null
          ? List<PokemonTypesModel>.from(
              (map['types'] as List<int>).map<PokemonTypesModel?>(
                (x) => PokemonTypesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      baseExperience: map['baseExperience'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonDetailsModel.fromJson(String source) =>
      PokemonDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PokemonAbilitiesModel {
  const PokemonAbilitiesModel({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  final PokemonAbilityModel? ability;
  final bool isHidden;
  final int slot;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ability': ability?.toMap(),
      'isHidden': isHidden,
      'slot': slot,
    };
  }

  factory PokemonAbilitiesModel.fromMap(Map<String, dynamic> map) {
    return PokemonAbilitiesModel(
      ability: map['ability'] != null
          ? PokemonAbilityModel.fromMap(map['ability'] as Map<String, dynamic>)
          : null,
      isHidden: map['isHidden'] as bool,
      slot: map['slot'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonAbilitiesModel.fromJson(String source) =>
      PokemonAbilitiesModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class PokemonAbilityModel {
  const PokemonAbilityModel({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory PokemonAbilityModel.fromMap(Map<String, dynamic> map) {
    return PokemonAbilityModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonAbilityModel.fromJson(String source) =>
      PokemonAbilityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PokemonTypesModel {
  const PokemonTypesModel({
    required this.slot,
    required this.type,
  });

  final int slot;
  final PokemonTypeModel type;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slot': slot,
      'type': type.toMap(),
    };
  }

  factory PokemonTypesModel.fromMap(Map<String, dynamic> map) {
    return PokemonTypesModel(
      slot: map['slot'] as int,
      type: PokemonTypeModel.fromMap(map['type'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonTypesModel.fromJson(String source) =>
      PokemonTypesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PokemonTypeModel {
  const PokemonTypeModel({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory PokemonTypeModel.fromMap(Map<String, dynamic> map) {
    return PokemonTypeModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonTypeModel.fromJson(String source) =>
      PokemonTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PokemonSpritesModel {
  const PokemonSpritesModel({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'backDefault': backDefault,
      'backFemale': backFemale,
      'backShiny': backShiny,
      'backShinyFemale': backShinyFemale,
      'frontDefault': frontDefault,
      'frontFemale': frontFemale,
      'frontShiny': frontShiny,
      'frontShinyFemale': frontShinyFemale,
    };
  }

  factory PokemonSpritesModel.fromMap(Map<String, dynamic> map) {
    return PokemonSpritesModel(
      backDefault:
          map['backDefault'] != null ? map['backDefault'] as String : null,
      backFemale:
          map['backFemale'] != null ? map['backFemale'] as String : null,
      backShiny: map['backShiny'] != null ? map['backShiny'] as String : null,
      backShinyFemale: map['backShinyFemale'] != null
          ? map['backShinyFemale'] as String
          : null,
      frontDefault:
          map['frontDefault'] != null ? map['frontDefault'] as String : null,
      frontFemale:
          map['frontFemale'] != null ? map['frontFemale'] as String : null,
      frontShiny:
          map['frontShiny'] != null ? map['frontShiny'] as String : null,
      frontShinyFemale: map['frontShinyFemale'] != null
          ? map['frontShinyFemale'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonSpritesModel.fromJson(String source) =>
      PokemonSpritesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}