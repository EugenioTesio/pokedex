import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoteImageSource {
  final http.Client client = http.Client();

  Future<Uint8List> fetchImage(String url) async {
    try {
      debugPrint('RemoteImageSource: fetchImage from $url');
      final response = await client.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        debugPrint('RemoteImageSource: Image not found');
        throw Exception('RemoteImageSource: Image not found');
      }
    } on Exception catch (e) {
      debugPrint('RemoteImageSource: error fetching image: $e');
      throw Exception('RemoteImageSource: error fetching image: $e');
    }
  }
}
