import 'package:pokedex/shared/image_cacher/data/datasource/local_image_source.dart';
import 'package:pokedex/shared/image_cacher/data/datasource/remote_image_source.dart';
import 'package:pokedex/shared/image_cacher/data/repositories/image_cacher_repository.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';
import 'package:pokedex/shared/image_cacher/domain/repositories/image_cacher_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final imageCacherRepositoryProvider = Provider<ImageCacherRepository>(
  (ref) {
    return ImageCacherRepositoryImpl(LocalImageSource(), RemoteImageSource());
  },
);

/// This provider is used to load the image from the cache or from the network.
/// The family parameters are the key and the url of the image.
final imageCacherFutureProvider =
    FutureProvider.family<ImageCacher?, (String key, String url)>(
  (ref, arg) async {
    final imageCacherRepository = ref.read(imageCacherRepositoryProvider);
    return imageCacherRepository.loadImage(key: arg.$1, url: arg.$2);
  },
);
