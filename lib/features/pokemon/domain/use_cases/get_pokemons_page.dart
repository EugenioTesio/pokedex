import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonsPage {
  GetPokemonsPage({required this.pokemonRepository});

  final PokemonRepository pokemonRepository;

  /// Get pokemons page from the repository.
  /// The parameter [page] starts at 1.
  Future<(PokemonList?, HttpClientException?)> call(int page) async {
    if (page < 1) {
      return (null, null);
    }
    const limit = 50;
    final offset = limit * (page - 1);
    return pokemonRepository.fetchPokemons(
      limit: limit,
      offset: offset,
    );
  }
}
