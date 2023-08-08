import 'dart:typed_data';

import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';
import 'package:pokedex/shared/image_cacher/domain/repositories/image_cacher_repository.dart';

/// Fake repository to be used in tests. The [imageCacher] property is exposed
/// so that it can be used to mock the return another value.
class FakeImageCacherRepository extends ImageCacherRepository {
  ImageCacher imageCacher = ImageCacher(
    imageBytes: Uint8List.fromList([1, 2, 3]),
    key: 'key',
    lastModified: DateTime.now(),
  );

  @override
  Future<ImageCacher?> loadImage({
    required String key,
    String? url,
  }) async {
    return imageCacher;
  }

  @override
  Future<void> saveImage(String key, Uint8List image) async {}
}
