import 'package:pokedex/shared/utils/network_info/domain/network_info.dart';

class FakeNetworkInfo implements NetworkInfo {
  bool isConnected = true;
  @override
  Future<bool?> checkConnection() async {
    return isConnected;
  }
}
