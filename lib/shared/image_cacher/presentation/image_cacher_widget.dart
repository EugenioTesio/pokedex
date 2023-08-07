import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/shared/image_cacher/domain/entity/image_cacher.dart';
import 'package:pokedex/shared/image_cacher/domain/providers/image_cacher_provider.dart';
import 'package:pokedex/shared/widgets/image_progress.dart';

class ImageCacherWidget extends ConsumerStatefulWidget {
  const ImageCacherWidget({
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.imageKey,
    this.fit,
    super.key,
  });

  final double width;
  final double height;
  final String imageUrl;
  final String imageKey;
  final BoxFit? fit;

  @override
  ConsumerState<ImageCacherWidget> createState() => _ImageCacherWidgetState();
}

class _ImageCacherWidgetState extends ConsumerState<ImageCacherWidget> {
  late AsyncValue<ImageCacher> asyncImageCacher;
  @override
  void initState() {
    asyncImageCacher = const AsyncValue.loading();
    ref
        .read(imageCacherRepositoryProvider)
        .loadImage(
          key: widget.imageKey,
          url: widget.imageUrl,
        )
        .then(
          (value) => setState(
            () => asyncImageCacher = AsyncValue.data(value),
          ),
        )
        .catchError(
          (error, stackTrace) => setState(
            () => asyncImageCacher = AsyncValue.error(error, stackTrace),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: asyncImageCacher.when(
          error: (error, stackTrace) => Icon(
            Icons.error,
            size: widget.width,
          ),
          loading: () => ShimmerImageProgress(
            size: widget.width,
          ),
          data: (imageCacher) => Image.memory(
            imageCacher.imageBytes,
            fit: widget.fit,
            height: widget.height,
            width: widget.width,
          ),
        ),
      ),
    );
  }
}
