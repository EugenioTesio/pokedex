import 'package:flutter/foundation.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';

class LocalImageSource {
  Future<ImageCacher?> loadImage(String key) async {
    debugPrint('LocalImageSource: loading image with key $key');
    final box = await HiveDatabase.openBox<ImageCacher>();
    final imageCacher = box.get(key);
    return imageCacher;
  }

  Future<void> saveImage(String key, Uint8List imageBytes) async {
    try {
      debugPrint('LocalImageSource: saving image with key $key');
      final box = await HiveDatabase.openBox<ImageCacher>();
      await box.put(
        key,
        ImageCacher(
          imageBytes: imageBytes,
          key: key,
          lastModified: DateTime.now(),
        ),
      );
    } on Exception catch (e) {
      debugPrint('LocalImageSource: error saving image $e');
      throw Exception('LocalImageSource: error saving image $e');
    }
  }
}
