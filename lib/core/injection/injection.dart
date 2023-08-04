import 'package:get_it/get_it.dart';
import 'package:pokedex/shared/utils/http_clients/api_http_client_impl.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt.registerLazySingleton<ApiHttpClient>(ApiHttpClient.new);
}
