import 'package:pokedex/shared/image_cacher/data/datasource/local_image_source.dart';
import 'package:pokedex/shared/image_cacher/data/datasource/remote_image_source.dart';
import 'package:pokedex/shared/image_cacher/data/repositories/image_cacher_repository.dart';
import 'package:pokedex/shared/image_cacher/domain/repositories/image_cacher_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final imageCacherRepositoryProvider = Provider<ImageCacherRepository>(
  (ref) {
    return ImageCacherRepositoryImpl(LocalImageSource(), RemoteImageSource());
  },
);
