import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/data/datasources/local_data_source.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  PokemonRepositoryImpl({
    required this.pokemonRemoteDataSource,
    required this.pokemonLocalDataSource,
  });

  PokemonRemoteDataSource pokemonRemoteDataSource;
  PokemonLocalDataSource pokemonLocalDataSource;

  @override
  Future<(PokemonDetails?, AppException?)> fetchPokemonDetails(
    String name,
  ) async {
    debugPrint(
      'PokemonRepositoryImpl: fetchPokemonDetails called with name: $name',
    );
    final response = await pokemonRemoteDataSource.fetchPokemonDetails(name);
    if (response.$1 != null) {
      debugPrint(
        'PokemonRepositoryImpl: fetched pokemon details with name $name '
        'from remote data source',
      );
      // if the response is not null, we save it to local storage
      await pokemonLocalDataSource.putPokemonDetailsModel(name, response.$1!);
      debugPrint(
        'PokemonRepositoryImpl: saved pokemon details with name: $name on '
        'database',
      );
      return (response.$1!.toEntity(), null);
    } else {
      debugPrint('Error fetching pokemon details: ${response.$2}');

      // if the response is null, we check if we have data in local storage
      final pokemonDetails =
          await pokemonLocalDataSource.getPokemonDetailsModel(name);

      if (pokemonDetails != null) {
        debugPrint(
          'PokemonRepositoryImpl: fetched pokemon details with name $name '
          'from local database',
        );
        return (pokemonDetails.toEntity(), response.$2);
      } else {
        debugPrint(
          'PokemonRepositoryImpl: no pokemon details with name $name '
          'in local database',
        );
        // return an error if we don't have data in local storage
        return (null, response.$2);
      }
    }
  }

  @override
  Future<(PokemonList?, AppException?)> fetchPokemons({
    int? limit,
    int offset = 0,
  }) async {
    debugPrint(
      'PokemonRepositoryImpl: fetchPokemons called with '
      '$limit, offset: $offset',
    );

    final wasFetchingFromLocalDataSource =
        await pokemonLocalDataSource.getComingFromDatabaseFlag();

    var result = await _getAndCacheData(
      limit: wasFetchingFromLocalDataSource ? offset + 50 : limit,
      offset: wasFetchingFromLocalDataSource ? 0 : offset,
    );

    // if success, clear localDataSource flag
    if (result.$1 != null) {
      await pokemonLocalDataSource.setComingFromDatabaseFlag(flag: false);
    }

    // if there was an error fetching data from remote return the pokemon list
    // from local storage
    if (result.$2 != null) {
      final dataSourceValue = await _getFromLocalDataStore();

      result = (dataSourceValue, result.$2);

      // set localDataSource flag
      await pokemonLocalDataSource.setComingFromDatabaseFlag(flag: true);
    }

    await pokemonLocalDataSource.closeAll();

    return result;
  }

  /// Return 1 page with all the [PokemonListItemModel]. The page will have
  /// the offset and limit properly set to fetch the next data
  Future<PokemonList> _getFromLocalDataStore() async {
    try {
      var count = 0;

      final pokemonListFromLocalDataSource = PokemonListModel(
        count: count,
        results: [],
      );

      for (final pokemonList
          in await pokemonLocalDataSource.getAllPokemonListModel()) {
        if (pokemonList != null) {
          pokemonListFromLocalDataSource.results.addAll(pokemonList.results);
          count += pokemonList.count;
        }
      }

      return pokemonListFromLocalDataSource.copyWith(count: count).toEntity();
    } on Exception catch (e) {
      debugPrint('Error fetching data from local storage: $e');
      return const PokemonList(count: 0, results: []);
    }
  }

  /// Fetch data from remote and cache it into local storage
  Future<(PokemonList?, AppException?)> _getAndCacheData({
    required int offset,
    int? limit,
  }) async {
    final response = await pokemonRemoteDataSource.fetchPokemons(
      limit: limit,
      offset: offset,
    );

    // add data to local storage
    if (response.$1 != null) {
      if (offset == 0) {
        // if offset == 0 means that we are fetching the first page
        await pokemonLocalDataSource.clearPokemonListModel();
      }

      response.$1!.offset = offset;
      await pokemonLocalDataSource.addPokemonListModel(response.$1!);
      return (response.$1!.toEntity(), null);
    } else {
      return (null, response.$2);
    }
  }

  @override
  Future<(PokemonDetails?, AppException?)> getPokemonDetails(
    String name,
  ) async {
    final pokemonDetails =
        await pokemonLocalDataSource.getPokemonDetailsModel(name);
    if (pokemonDetails != null) {
      return (pokemonDetails.toEntity(), null);
    } else {
      return fetchPokemonDetails(name);
    }
  }
}
