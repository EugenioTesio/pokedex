// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';

part 'pokemon_list_model.g.dart';

@HiveType(typeId: HiveConstants.pokemonListModel)
class PokemonListModel {
  PokemonListModel({
    required this.count,
    required this.results,
    this.next,
    this.previous,
    this.offset = 0,
  });

  @HiveField(0)
  final int count;
  @HiveField(1)
  final String? next;
  @HiveField(2)
  final String? previous;
  @HiveField(3)
  final List<PokemonListItemModel> results;
  @HiveField(4)
  int offset;

  PokemonList toEntity() {
    return PokemonList(
      count: count,
      next: next,
      previous: previous,
      results: results.map((x) => x.toEntity()).toList(),
    );
  }

  PokemonListModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonListItemModel>? results,
  }) {
    return PokemonListModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory PokemonListModel.fromMap(Map<String, dynamic> map) {
    return PokemonListModel(
      count: map['count'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      previous: map['previous'] != null ? map['previous'] as String : null,
      results: List<PokemonListItemModel>.from(
        (map['results'] as List).map<PokemonListItemModel>(
          (x) => PokemonListItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonListModel.fromJson(String source) =>
      PokemonListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PokemonListModel(count: $count, next: $next, previous: $previous,'
        ' results: $results)';
  }
}

@HiveType(typeId: HiveConstants.pokemonListItemModel)
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

  @HiveField(0)
  final String name;
  @HiveField(1)
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
