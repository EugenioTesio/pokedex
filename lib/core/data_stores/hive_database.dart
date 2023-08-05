import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_details_model.dart';
import 'package:pokedex/features/pokemon/data/models/pokemon_list_model.dart';

abstract class HiveConstants {
  static const int pokemonListModel = 1;
  static const int pokemonDetailsModel = 2;
  static const int pokemonListSource = 3;
}

class HiveDatabase {
  static Future<void> initialize({String? subDir}) async {
    await Hive.initFlutter(subDir);
    Hive
      ..registerAdapter(PokemonListModelAdapter())
      ..registerAdapter(PokemonDetailsModelAdapter())
      ..registerAdapter(PokemonListSourceAdapter());
  }

  /// Open a hive box of the given name.
  /// If there's an error parsing the box data, delete the box and return
  /// a fresh box.
  static Future<Box<T>> openBox<T>() async {
    final boxName = (T).toString();
    try {
      final box = await Hive.openBox<T>(boxName);
      return box;
    } catch (e) {
      if (await Hive.boxExists(boxName)) {
        await Hive.deleteBoxFromDisk(boxName);
      }
      return Hive.openBox<T>(boxName);
    }
  }
}
