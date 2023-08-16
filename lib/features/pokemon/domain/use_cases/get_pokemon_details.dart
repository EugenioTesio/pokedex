import 'package:pokedex/core/http_client/domain/app_exception.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/shared/analytics/domain/entities/event.dart';
import 'package:pokedex/shared/analytics/domain/repositories/analytic_respository.dart';

class GetPokemonDetails {
  GetPokemonDetails({
    required this.pokemonRepository,
    required this.analyticRepository,
  });

  final PokemonRepository pokemonRepository;
  final AnalyticRepository analyticRepository;

  Future<(PokemonDetails?, AppException?)> call(String name) async {
    await analyticRepository.logEvent(
      Event(
        name: 'get_pokemon_details',
        params: {'name': name},
      ),
    );
    return pokemonRepository.getPokemonDetails(name);
  }
}
