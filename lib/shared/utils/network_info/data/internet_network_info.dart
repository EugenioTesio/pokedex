import 'package:dart_ping/dart_ping.dart';
import 'package:pokedex/shared/utils/network_info/domain/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool?> checkConnection() async {
    final ping = Ping('google.com', count: 1);
    return ping.stream.listen(null).asFuture<bool>(true);
  }
}
