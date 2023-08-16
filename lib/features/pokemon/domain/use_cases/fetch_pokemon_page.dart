import 'package:flutter/material.dart';
import 'package:pokedex/core/http_client/domain/app_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/shared/analytics/domain/entities/event.dart';
import 'package:pokedex/shared/analytics/domain/repositories/analytic_respository.dart';

class FetchPokemonPage {
  FetchPokemonPage({
    required this.pokemonRepository,
    required this.analyticRepository,
  });

  final PokemonRepository pokemonRepository;
  final AnalyticRepository analyticRepository;

  /// Get pokemons page from the repository.
  /// The parameter [page] starts at 1.
  Future<(PokemonList?, AppException?)> call(int page) async {
    debugPrint('FetchPokemonPage: page: $page');
    if (page < 1) {
      return (null, null);
    }
    const limit = 50;
    final offset = limit * (page - 1);
    await analyticRepository.logEvent(
      Event(
        name: 'fetch_pokemon_page',
        params: {'page': page},
      ),
    );
    return pokemonRepository.fetchPokemons(
      limit: limit,
      offset: offset,
    );
  }
}
