import 'dart:convert';
import 'dart:io';

import 'package:pokedex/core/http_client/domain/app_exception.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_details.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_list.dart';
import 'package:pokedex/features/pokemon/domain/repositories/pokemon_repository.dart';

/// Fake implementation of [PokemonRepository] to be used in tests. Exposes the
/// [pokemonList] and [pokemonDetails] to be changed at wild. Also exposes the
/// [fetchPokemonsApiException], [fetchPokemonDetailsApiException] and
/// [getPokemonDetailsApiException] to be changed and force the exception.
class FakePokemonRepository implements PokemonRepository {
  PokemonListModel? pokemonList;
  PokemonDetailsModel? pokemonDetails;

  AppException? fetchPokemonsApiException;
  AppException? fetchPokemonDetailsApiException;
  AppException? getPokemonDetailsApiException;

  @override
  Future<(PokemonList?, AppException?)> fetchPokemons({
    int? limit,
    int offset = 0,
  }) async {
    if (pokemonList == null) {
      final pokemonListJsonFile = File('test/resources/pokemon_list.json');
      final pokemonListJsonString = await pokemonListJsonFile.readAsString();
      final json = jsonDecode(pokemonListJsonString);
      pokemonList = PokemonListModel.fromJson(json);
    }
    if (fetchPokemonsApiException != null) {
      return (null, fetchPokemonsApiException);
    }
    final results = pokemonList!.results
        .skip(offset)
        .take(limit ?? pokemonList!.results.length)
        .map((e) => e.toEntity())
        .toList();
    return (pokemonList!.toEntity().copyWith(results: results), null);
  }

  @override
  Future<(PokemonDetails?, AppException?)> fetchPokemonDetails(
    String id,
  ) async {
    if (fetchPokemonDetailsApiException != null) {
      return (null, fetchPokemonDetailsApiException);
    }
    pokemonDetails ??= await _fetchFakePokemonDetails();
    return (pokemonDetails!.toEntity(), null);
  }

  @override
  Future<(PokemonDetails?, AppException?)> getPokemonDetails(
    String name,
  ) async {
    if (getPokemonDetailsApiException != null) {
      return (null, getPokemonDetailsApiException);
    }
    pokemonDetails ??= await _fetchFakePokemonDetails();
    return (pokemonDetails!.toEntity(), null);
  }

  Future<PokemonDetailsModel> _fetchFakePokemonDetails() async {
    final pokemonDetailsJsonFile = File('test/resources/pokemon_details.json');
    final pokemonDetailsJsonString =
        await pokemonDetailsJsonFile.readAsString();
    final json = jsonDecode(pokemonDetailsJsonString);
    return PokemonDetailsModel.fromJson(json);
  }
}
