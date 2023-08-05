import 'package:pokedex/core/constants/urls.dart';
import 'package:pokedex/core/http_client/data/api_http_client_impl.dart';
import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';

class PokemonRemoteDataSource {
  PokemonRemoteDataSource(this.client);

  final ApiHttpClient client;

  Future<(PokemonListModel?, HttpClientException?)> fetchPokemons({
    int? limit,
    int? offset,
  }) async {
    return client.get(
      endpoint: pokemonV2Url,
      queryParams: {'limit': limit, 'offset': offset},
      deserializeResponseFunction: PokemonListModel.fromMap,
    );
  }

  Future<(PokemonDetailsModel?, HttpClientException?)> fetchPokemonDetails(
    String name,
  ) async {
    return client.get(
      endpoint: pokemonV2Url,
      queryParams: {'name': name},
      deserializeResponseFunction: PokemonDetailsModel.fromMap,
    );
  }
}
