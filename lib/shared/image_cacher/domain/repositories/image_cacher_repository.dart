import 'dart:typed_data';

import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';

abstract class ImageCacherRepository {
  Future<ImageCacher?> loadImage(String url);
  Future<void> saveImage(String url, Uint8List image);
}
