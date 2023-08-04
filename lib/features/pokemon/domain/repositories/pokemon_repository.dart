import 'package:pokedex/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';

abstract class PokemonRepository {
  Future<List<PokemonList>> fetchPokemons(int? limit, int? offset);
  Future<PokemonDetails> fetchPokemonDetails(String id);
}
