import 'package:dart_ping/dart_ping.dart';

abstract class ConnectionManager {
  Future<bool?> checkConnection();
}

class ConnectionManagerImpl implements ConnectionManager {
  @override
  Future<bool?> checkConnection() async {
    final ping = Ping('google.com', count: 1);
    return ping.stream.listen(null).asFuture<bool>(true);
  }
}

class FakeConnectionManager implements ConnectionManager {
  bool isConnected = true;
  @override
  Future<bool?> checkConnection() async {
    return isConnected;
  }
}
