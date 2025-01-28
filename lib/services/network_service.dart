// lib/services/network_service.dart

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static Future<bool> isConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
  static Stream<bool> connectivityStream(){
     return Connectivity().onConnectivityChanged
        .map((result) => result != ConnectivityResult.none);
  }
}