import 'package:dart_ping/dart_ping.dart';

abstract class NetworkInfo {
  Future<bool?> checkConnection();
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool?> checkConnection() async {
    final ping = Ping('google.com', count: 1);
    return ping.stream.listen(null).asFuture<bool>(true);
  }
}

class FakeNetworkInfo implements NetworkInfo {
  bool isConnected = true;
  @override
  Future<bool?> checkConnection() async {
    return isConnected;
  }
}
