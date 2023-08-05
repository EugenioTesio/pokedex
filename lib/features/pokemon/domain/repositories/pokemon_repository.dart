import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';

abstract class PokemonRepository {
  Future<(PokemonList?, HttpClientException?)> fetchPokemons({
    int? limit,
    int offset = 0,
  });
  Future<(PokemonDetails?, HttpClientException?)> fetchPokemonDetails(
    String name,
  );
}
