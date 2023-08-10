import 'package:pokedex/core/http_client/domain/app_exception.dart';
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
  Future<(PokemonDetails?, AppException?)> getPokemonDetails(
    String name,
  );
}
