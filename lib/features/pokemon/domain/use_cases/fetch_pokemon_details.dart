import 'package:pokedex/core/http_client/domain/app_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/shared/analytics/domain/entities/event.dart';
import 'package:pokedex/shared/analytics/domain/repositories/analytic_respository.dart';

class FetchPokemonDetails {
  FetchPokemonDetails({
    required this.pokemonRepository,
    required this.analyticRepository,
  });

  final PokemonRepository pokemonRepository;
  final AnalyticRepository analyticRepository;

  Future<(PokemonDetails?, AppException?)> call(String id) async {
    await analyticRepository.logEvent(
      Event(
        name: 'fetch_pokemon_details',
        params: {
          'name': id,
        },
      ),
    );
    return pokemonRepository.fetchPokemonDetails(id);
  }
}
