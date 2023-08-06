import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/urls.dart';
import 'package:pokedex/core/http_client/data/api_http_client_impl.dart';

final httpClientProvider = Provider((ref) => ApiHttpClient(pokeApiV2Url));
