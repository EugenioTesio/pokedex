import 'dart:typed_data';

import 'package:pokedex/shared/image_cacher/data/datasource/local_image_source.dart';
import 'package:pokedex/shared/image_cacher/data/datasource/remote_image_source.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';
import 'package:pokedex/shared/image_cacher/domain/repositories/image_cacher_repository.dart';

class ImageCacherRepositoryImpl extends ImageCacherRepository {
  ImageCacherRepositoryImpl(this.localImageSource, this.remoteImageSource);

  final LocalImageSource localImageSource;
  final RemoteImageSource remoteImageSource;

  @override
  Future<ImageCacher?> loadImage(String url) async {
    final image = await localImageSource.loadImage(url);
    if (image != null) {
      return image;
    } else {
      final image = await remoteImageSource.fetchImage(url);
      if (image != null) {
        await localImageSource.saveImage(url, image);
        return ImageCacher(
          imageBytes: image,
          key: url,
          lastModified: DateTime.now(),
        );
      } else {
        return null;
      }
    }
  }

  @override
  Future<void> saveImage(String url, Uint8List image) async {
    await localImageSource.saveImage(url, image);
  }
}
