import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class RemoteImageSource {
  Future<Uint8List?> fetchImage(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'image/*',
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      return response.bodyBytes;
    } else {
      return null;
    }
  }
}
