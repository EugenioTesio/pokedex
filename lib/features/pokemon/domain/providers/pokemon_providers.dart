import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/http_client/domain/http_client_provider.dart';
import 'package:pokedex/features/pokemon/data/datasources/local_data_source.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/fetch_pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/fetch_pokemon_page.dart';
import 'package:pokedex/features/pokemon/domain/use_cases/get_pokemon_details.dart';

final pokemonRemoteDataSourceProvider =
    Provider<PokemonRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return PokemonRemoteDataSource(httpClient);
});

final pokemonLocalDataSourceProvider = Provider<PokemonLocalDataSource>((ref) {
  return PokemonLocalDataSource();
});

final pokemonListRepositoryProvider = Provider<PokemonRepository>((ref) {
  final pokemonRemoteDataSource = ref.watch(pokemonRemoteDataSourceProvider);
  final pokemonLocalDataSource = ref.watch(pokemonLocalDataSourceProvider);
  return PokemonRepositoryImpl(
    pokemonRemoteDataSource: pokemonRemoteDataSource,
    pokemonLocalDataSource: pokemonLocalDataSource,
  );
});

final fetchPokemonPageProvider = Provider<FetchPokemonPage>((ref) {
  final pokemonRepository = ref.watch(pokemonListRepositoryProvider);
  return FetchPokemonPage(pokemonRepository: pokemonRepository);
});

final fetchPokemonsDetailsProvider = Provider<FetchPokemonDetails>((ref) {
  final pokemonRepository = ref.watch(pokemonListRepositoryProvider);
  return FetchPokemonDetails(pokemonRepository: pokemonRepository);
});

final getPokemonDetailsProvider = Provider<GetPokemonDetails>((ref) {
  final pokemonRepository = ref.watch(pokemonListRepositoryProvider);
  return GetPokemonDetails(pokemonRepository: pokemonRepository);
});
