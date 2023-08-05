import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonDetatails {
  GetPokemonDetatails({
    required this.pokemonRepository,
  });

  final PokemonRepository pokemonRepository;

  Future<(PokemonDetails?, AppException?)> call(String name) async {
    return pokemonRepository.fetchPokemonDetails(name);
  }
}
