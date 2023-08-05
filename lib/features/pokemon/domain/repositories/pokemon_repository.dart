import 'package:pokedex/core/http_client/http_client.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';

abstract class PokemonRepository {
  Future<(PokemonList?, HttpClientException?)> fetchPokemons({
    int? limit,
    int offset = 0,
  });
  Future<(PokemonDetails, HttpClientException?)> fetchPokemonDetails(String id);
}
