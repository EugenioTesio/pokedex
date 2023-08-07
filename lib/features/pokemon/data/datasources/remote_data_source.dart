import 'package:pokedex/core/constants/urls.dart';
import 'package:pokedex/core/http_client/data/api_http_client_impl.dart';
import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';

class PokemonRemoteDataSource {
  PokemonRemoteDataSource(this.client);

  final ApiHttpClient client;

  Future<(PokemonListModel?, AppException?)> fetchPokemons({
    int? limit,
    int? offset,
  }) async {
    return client.get(
      endpoint: pokemonEndpoint,
      queryParams: {
        'limit': limit.toString(),
        'offset': offset.toString(),
      },
      deserializeResponseFunction: PokemonListModel.fromMap,
    );
  }

  Future<(PokemonDetailsModel?, AppException?)> fetchPokemonDetails(
    String name,
  ) async {
    return client.get(
      endpoint: '$pokemonEndpoint/$name',
      deserializeResponseFunction: PokemonDetailsModel.fromMap,
    );
  }
}
