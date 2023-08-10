import 'package:pokedex/core/http_client/domain/app_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonDetails {
  GetPokemonDetails({
    required this.pokemonRepository,
  });

  final PokemonRepository pokemonRepository;

  Future<(PokemonDetails?, AppException?)> call(String name) async {
    return pokemonRepository.getPokemonDetails(name);
  }
}
