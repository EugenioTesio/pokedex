import 'dart:typed_data';

import 'package:pokedex/core/data_stores/hive_database.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';

class LocalImageSource {
  Future<ImageCacher?> loadImage(String key) async {
    final box = await HiveDatabase.openBox<ImageCacher>();
    return box.get(key);
  }

  Future<void> saveImage(String key, Uint8List image) async {
    final box = await HiveDatabase.openBox<ImageCacher>();
    await box.put(
      key,
      ImageCacher(
        imageBytes: image,
        key: key,
        lastModified: DateTime.now(),
      ),
    );
  }
}
