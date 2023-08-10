import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/shared/image_cacher/domain/providers/image_cacher_provider.dart';
import 'package:pokedex/shared/widgets/image_progress.dart';
import 'package:pokedex/shared/widgets/no_image_placeholder.dart';

class ImageCacherWidget extends ConsumerWidget {
  const ImageCacherWidget({
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.imageKey,
    this.fit,
    this.color,
    super.key,
  });

  final double width;
  final double height;
  final String imageUrl;
  final String imageKey;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: color,
          child: ref
              .watch(
                imageCacherFutureProvider((imageKey, imageUrl)),
              )
              .when(
                error: (error, stackTrace) => Icon(
                  Icons.error,
                  size: width,
                ),
                loading: () => ShimmerImageProgress(
                  size: width,
                ),
                data: (imageCacher) => imageCacher != null
                    ? Image.memory(
                        imageCacher.imageBytes,
                        fit: BoxFit.fill,
                      )
                    : const NoImagePlaceholder(),
              ),
        ),
      ),
    );
  }
}
