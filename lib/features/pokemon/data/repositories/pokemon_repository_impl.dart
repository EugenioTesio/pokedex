import 'dart:async';

import 'package:hive/hive.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';
import 'package:pokedex/core/http_client/domain/http_client_exception.dart';
import 'package:pokedex/features/pokemon/data/datasources/remote_data_source.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex/shared/utils/network_info/domain/network_info.dart';

class PokemonRepositoryImpl extends PokemonRepository {
  PokemonRepositoryImpl({
    required this.pokemonRemoteDataSource,
    required this.networkInfo,
  });

  PokemonRemoteDataSource pokemonRemoteDataSource;
  NetworkInfo networkInfo;

  @override
  Future<(PokemonDetails?, HttpClientException?)> fetchPokemonDetails(
    String name,
  ) async {
    final response = await pokemonRemoteDataSource.fetchPokemonDetails(name);
    final pokemonDetailsBox = await HiveDatabase.openBox<PokemonDetailsModel>();
    if (response.$1 != null) {
      // if the response is not null, we save it to local storage
      await pokemonDetailsBox.clear();
      await pokemonDetailsBox.put(name, response.$1!);
      await pokemonDetailsBox.close();

      return (response.$1!.toEntity(), null);
    } else {
      // if the response is null, we check if we have data in local storage
      final pokemonDetails = pokemonDetailsBox.get(name);
      await pokemonDetailsBox.close();
      if (pokemonDetails != null) {
        return (pokemonDetails.toEntity(), response.$2);
      } else {
        // return an error if we don't have data in local storage
        await pokemonDetailsBox.close();
        return (null, response.$2);
      }
    }
  }

  @override
  Future<(PokemonList?, HttpClientException?)> fetchPokemons({
    int? limit,
    int offset = 0,
  }) async {
    final isConnected = (await networkInfo.checkConnection()) ?? false;
    final pokemonListModelBox = await HiveDatabase.openBox<PokemonListModel>();
    final pokemonListSourceBox =
        await HiveDatabase.openBox<PokemonListSource>();

    (PokemonList?, HttpClientException?) result = (
      null,
      HttpClientException(
        apiExceptionType: HttpClientExceptionType.networkError,
        message: 'No internet connection',
      )
    );

    if (offset == 0 && isConnected) {
      // if offset == 0 means that we are fetching the first page
      await pokemonListModelBox.clear();

      // change the localDataSource flag to true
      await pokemonListSourceBox.clear();
      await pokemonListSourceBox.add(const PokemonListSource());

      result = await _getAndCacheData(limit, offset, pokemonListModelBox);
    }

    if (offset == 0 && !isConnected) {
      // return 1 object with all the records and with the next value prepared
      // to fecth the next page
      final lastPokemonListFetched = pokemonListModelBox.values.last;

      for (var i = 0; i < pokemonListModelBox.length; i++) {
        final pokemonList = pokemonListModelBox.getAt(i);
        if (i == pokemonListModelBox.length - 1) {
          lastPokemonListFetched.results.addAll(pokemonList!.results);
        }
      }

      result = (lastPokemonListFetched.toEntity(), null);
    }

    if (offset != 0 && isConnected) {
      result = await _getAndCacheData(limit, offset, pokemonListModelBox);
    }

    await pokemonListModelBox.close();
    await pokemonListSourceBox.close();

    return result;
  }

  /// Fetch data from remote and cache it into local storage
  Future<(PokemonList?, HttpClientException?)> _getAndCacheData(
    int? limit,
    int offset,
    Box<PokemonListModel> pokemonListModelBox,
  ) async {
    final response = await pokemonRemoteDataSource.fetchPokemons(
      limit: limit,
      offset: offset,
    );

    // add data to local storage
    if (response.$1 != null) {
      response.$1!.offset = offset;
      await pokemonListModelBox.add(response.$1!);
      return (response.$1!.toEntity(), null);
    } else {
      return (null, response.$2);
    }
  }
}
