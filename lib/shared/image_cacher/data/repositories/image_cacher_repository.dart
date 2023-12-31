import 'package:flutter/foundation.dart';
import 'package:pokedex/shared/image_cacher/data/datasource/local_image_source.dart';
import 'package:pokedex/shared/image_cacher/data/datasource/remote_image_source.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';
import 'package:pokedex/shared/image_cacher/domain/repositories/image_cacher_repository.dart';
import 'package:rxdart/subjects.dart';

class ImageCacherRepositoryImpl extends ImageCacherRepository {
  ImageCacherRepositoryImpl(this.localImageSource, this.remoteImageSource);

  final LocalImageSource localImageSource;
  final RemoteImageSource remoteImageSource;
  final BehaviorSubject<ImageCacher?> _imageCacherSubject =
      BehaviorSubject<ImageCacher?>();

  @override
  Future<ImageCacher?> loadImage({
    required String key,
    String? url,
  }) async {
    debugPrint('ImageCacherRepositoryImpl: loading image with key $key and '
        'url $url');
    final image = await localImageSource.loadImage(key);
    if (image != null) {
      _imageCacherSubject.add(image);
      return image;
    }
    if (url != null) {
      final image = await remoteImageSource.fetchImage(url);
      await localImageSource.saveImage(key, image);
      final result = ImageCacher(
        imageBytes: image,
        key: key,
        lastModified: DateTime.now(),
      );
      _imageCacherSubject.add(result);
      return result;
    } else {
      return null;
    }
  }

  @override
  Future<void> saveImage(String key, Uint8List image) async {
    await localImageSource.saveImage(key, image);
    _imageCacherSubject.add(
      ImageCacher(
        imageBytes: image,
        key: key,
        lastModified: DateTime.now(),
      ),
    );
  }

  @override
  Stream<ImageCacher?> get imageCacherStream => _imageCacherSubject.stream;
}
