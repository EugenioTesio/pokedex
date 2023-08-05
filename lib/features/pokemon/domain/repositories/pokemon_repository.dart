import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';

abstract class PokemonRepository {
  Future<(PokemonList?, AppException?)> fetchPokemons({
    int? limit,
    int offset = 0,
  });
  Future<(PokemonDetails?, AppException?)> fetchPokemonDetails(
    String name,
  );
}
