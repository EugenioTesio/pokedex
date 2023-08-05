import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/shared/utils/network_info/data/internet_network_info.dart';

abstract class NetworkInfo {
  Future<bool?> checkConnection();
}

final networkInfoProvider = Provider<NetworkInfo>(
  (ref) {
    return NetworkInfoImpl();
  },
);
