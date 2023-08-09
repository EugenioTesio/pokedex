import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';
import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  PokemonRepositoryImpl({
    required this.pokemonRemoteDataSource,
  });

  PokemonRemoteDataSource pokemonRemoteDataSource;

  @override
  Future<(PokemonDetails?, AppException?)> fetchPokemonDetails(
    String name,
  ) async {
    debugPrint(
      'PokemonRepositoryImpl: fetchPokemonDetails called with name: $name',
    );
    final response = await pokemonRemoteDataSource.fetchPokemonDetails(name);
    final pokemonDetailsBox = await HiveDatabase.openBox<PokemonDetailsModel>();
    if (response.$1 != null) {
      debugPrint(
        'PokemonRepositoryImpl: fetched pokemon details from remote '
        'data source',
      );
      // if the response is not null, we save it to local storage
      await pokemonDetailsBox.clear();
      await pokemonDetailsBox.put(name, response.$1!);

      return (response.$1!.toEntity(), null);
    } else {
      debugPrint('Error fetching pokemon details: ${response.$2}');
      // if the response is null, we check if we have data in local storage
      final pokemonDetails = pokemonDetailsBox.get(name);
      if (pokemonDetails != null) {
        debugPrint(
          'PokemonRepositoryImpl: fetched pokemon details from local database',
        );
        return (pokemonDetails.toEntity(), response.$2);
      } else {
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
    final pokemonListModelBox = await HiveDatabase.openBox<PokemonListModel>();
    final pokemonListSourceBox =
        await HiveDatabase.openBox<PokemonListSource>();

    final wasFetchingFromLocalDataSource =
        pokemonListSourceBox.get(0)?.localDataSource ?? false;

    var result = await _getAndCacheData(
      limit: wasFetchingFromLocalDataSource ? offset + 50 : limit,
      offset: wasFetchingFromLocalDataSource ? 0 : offset,
      pokemonListModelBox: pokemonListModelBox,
    );

    // if success, clear localDataSource flag
    if (result.$1 != null) {
      await pokemonListSourceBox.clear();
      await pokemonListSourceBox.add(const PokemonListSource());
    }

    // if there was an error fetching data from remote return the pokemon list
    // from local storage
    if (result.$2 != null) {
      final dataSourceValue = _getFromLocalDataStore(
        pokemonListModelBox: pokemonListModelBox,
      );

      result = (dataSourceValue, result.$2);

      // set localDataSource flag
      await pokemonListSourceBox.clear();
      await pokemonListSourceBox.add(
        const PokemonListSource(localDataSource: true),
      );
    }

    await pokemonListModelBox.close();
    await pokemonListSourceBox.close();

    return result;
  }

  /// Return 1 page with all the [PokemonListItemModel]. The page will have
  /// the offset and limit properly set to fetch the next data
  PokemonList _getFromLocalDataStore({
    required Box<PokemonListModel> pokemonListModelBox,
  }) {
    try {
      var count = 0;

      final pokemonListFromLocalDataSource = PokemonListModel(
        count: count,
        results: [],
      );

      for (final pokemonList in pokemonListModelBox.values) {
        pokemonListFromLocalDataSource.results.addAll(pokemonList.results);
        count += pokemonList.count;
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
    required Box<PokemonListModel> pokemonListModelBox,
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
        await pokemonListModelBox.clear();
      }

      response.$1!.offset = offset;
      await pokemonListModelBox.add(response.$1!);
      return (response.$1!.toEntity(), null);
    } else {
      return (null, response.$2);
    }
  }

  @override
  Future<(PokemonDetails?, AppException?)> getPokemonDetails(
    String name,
  ) async {
    final pokemonDetailsBox = await HiveDatabase.openBox<PokemonDetailsModel>();
    final pokemonDetails = pokemonDetailsBox.get(name);
    if (pokemonDetails != null) {
      await pokemonDetailsBox.close();
      return (pokemonDetails.toEntity(), null);
    } else {
      return fetchPokemonDetails(name);
    }
  }
}
