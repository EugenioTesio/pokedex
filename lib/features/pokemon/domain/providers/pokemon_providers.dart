import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/http_client/domain/http_client_provider.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/shared/utils/network_info/domain/network_info.dart';

final pokemonRemoteDataSourceProvider =
    Provider<PokemonRemoteDataSource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return PokemonRemoteDataSource(httpClient);
});

final pokemonListRepositoryProvider = Provider<PokemonRepository>((ref) {
  final pokemonRemoteDataSource = ref.watch(pokemonRemoteDataSourceProvider);
  final newtworkInfo = ref.watch(networkInfoProvider);
  return PokemonRepositoryImpl(
    pokemonRemoteDataSource: pokemonRemoteDataSource,
    networkInfo: newtworkInfo,
  );
});
