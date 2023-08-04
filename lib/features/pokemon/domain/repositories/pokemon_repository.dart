import 'package:pokedex/features/pokemon/domain/models/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/models/pokemon_details.dart';

abstract class PokemonRepository {
  Future<List<PokemonList>> fetchPokemons(int? limit, int? offset);
  Future<PokemonDetailsDto> fetchPokemonDetails(String id);
}
