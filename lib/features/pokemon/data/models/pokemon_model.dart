// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PokemonListModel {
  const PokemonListModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
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

  final int count;
  final String next;
  final String previous;
  final List<PokemonListItemModel> results;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
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

  @override
  String toString() => 'PokemonListItemModel(name: $name, url: $url)';
}
