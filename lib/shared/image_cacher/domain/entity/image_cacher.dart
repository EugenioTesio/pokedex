// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';

part 'image_cacher.g.dart';

@HiveType(typeId: HiveConstants.imageCacher)
class ImageCacher {
  const ImageCacher({
    required this.imageBytes,
    required this.key,
    required this.lastModified,
  });

  @HiveField(0)
  final Uint8List imageBytes;
  @HiveField(1)
  final String key;
  @HiveField(2)
  final DateTime lastModified;

  @override
  String toString() => 'ImageCacher(imageBytes: $imageBytes, key: $key, '
      'lastModified: $lastModified)';
}

class ImageCacherLoadPayload {
  const ImageCacherLoadPayload({
    required this.key,
    required this.url,
  });

  final String key;
  final String url;
}
