import 'dart:typed_data';

class ImageCacher {
  const ImageCacher({
    required this.imageBytes,
    required this.key,
    required this.lastModified,
  });

  final Uint8List imageBytes;
  final String key;
  final DateTime lastModified;
}
