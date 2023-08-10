import 'package:pokedex/core/data_stores/hive_database.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';

class PokemonLocalDataSource {
  Future<void> addPokemonListModel(PokemonListModel pokemonListModel) async {
    final pokemonBox = await HiveDatabase.openBox<PokemonListModel>();
    await pokemonBox.add(pokemonListModel);
  }

  Future<void> putPokemonDetailsModel(
    String key,
    PokemonDetailsModel pokemonModel,
  ) async {
    final pokemonDetailsBox = await HiveDatabase.openBox<PokemonDetailsModel>();
    await pokemonDetailsBox.put(key, pokemonModel);
  }

  Future<Iterable<PokemonListModel?>> getAllPokemonListModel() async {
    final pokemonBox = await HiveDatabase.openBox<PokemonListModel>();
    return pokemonBox.values;
  }

  Future<PokemonDetailsModel?> getPokemonDetailsModel(String key) async {
    final pokemonDetailsBox = await HiveDatabase.openBox<PokemonDetailsModel>();
    return pokemonDetailsBox.get(key);
  }

  Future<void> clearPokemonDetailsModel() async {
    final pokemonDetailsBox = await HiveDatabase.openBox<PokemonDetailsModel>();
    await pokemonDetailsBox.clear();
  }

  Future<void> clearPokemonListModel() async {
    final pokemonBox = await HiveDatabase.openBox<PokemonListModel>();
    await pokemonBox.clear();
  }

  Future<void> clearAll() async {
    await clearPokemonDetailsModel();
    await clearPokemonListModel();
  }

  Future<void> closeAll() async {
    final pokemonDetailsBox = await HiveDatabase.openBox<PokemonDetailsModel>();
    await pokemonDetailsBox.close();
    final pokemonBox = await HiveDatabase.openBox<PokemonListModel>();
    await pokemonBox.close();
  }

  Future<void> setComingFromDatabaseFlag({required bool flag}) async {
    final box = await HiveDatabase.openBox<bool>();
    await box.put(0, flag);
  }

  Future<bool> getComingFromDatabaseFlag() async {
    final box = await HiveDatabase.openBox<bool>();
    return box.get(0) ?? false;
  }
}
