import 'package:pokedex/core/constants/urls.dart';
import 'package:pokedex/core/http_client/http_client.dart';
import 'package:pokedex/core/injection/injection.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';
import 'package:pokedex/shared/utils/http_clients/api_http_client_impl.dart';

class PokemonRemoteDataSource {
  final ApiHttpClient client = getIt<ApiHttpClient>();

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
