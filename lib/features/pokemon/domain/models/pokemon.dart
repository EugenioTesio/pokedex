import 'package:equatable/equatable.dart';

class PokemonList extends Equatable {
  const PokemonList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<PokemonListItem> results;

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];

  PokemonList copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonListItem>? results,
  }) {
    return PokemonList(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}

class PokemonListItem extends Equatable {
  const PokemonListItem({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  @override
  List<Object?> get props => [
        name,
        url,
      ];

  PokemonListItem copyWith({
    String? name,
    String? url,
  }) {
    return PokemonListItem(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
