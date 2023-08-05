import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';

part 'pokemon_list_model.g.dart';

@HiveType(typeId: HiveConstants.pokemonListModel)
class PokemonListModel {
  PokemonListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
    this.offset = 0,
  });

  factory PokemonListModel.fromMap(Map<String, dynamic> map) {
    return PokemonListModel(
      count: map['count'] as int,
      next: map['next'] as String,
      previous: map['previous'] as String,
      results: List<PokemonListItemModel>.from(
        (map['results'] as List<int>).map<PokemonListItemModel>(
          (x) => PokemonListItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory PokemonListModel.fromJson(String source) =>
      PokemonListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @HiveField(0)
  final int count;
  @HiveField(1)
  final String next;
  @HiveField(2)
  final String previous;
  @HiveField(3)
  final List<PokemonListItemModel> results;
  @HiveField(4)
  int offset;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  PokemonList toEntity() {
    return PokemonList(
      count: count,
      next: next,
      previous: previous,
      results: results.map((x) => x.toEntity()).toList(),
    );
  }
}

class PokemonListItemModel {
  const PokemonListItemModel({
    required this.name,
    required this.url,
  });

  factory PokemonListItemModel.fromMap(Map<String, dynamic> map) {
    return PokemonListItemModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  factory PokemonListItemModel.fromJson(String source) =>
      PokemonListItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  final String name;
  final String url;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  String toJson() => json.encode(toMap());

  PokemonListItem toEntity() {
    return PokemonListItem(
      name: name,
      url: url,
    );
  }

  @override
  String toString() => 'PokemonListItemModel(name: $name, url: $url)';
}

@HiveType(typeId: HiveConstants.pokemonListSource)
class PokemonListSource {
  const PokemonListSource({
    this.localDataSource = false,
  });
  @HiveField(0)
  final bool localDataSource;
}
