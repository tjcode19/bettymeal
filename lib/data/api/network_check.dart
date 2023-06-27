import 'dart:io';

import 'network_manager.dart';


class NetworkCheck extends NetworkManager {
  

  @override
  Future<bool> isConnected() async {
    bool res = false;
    try {
      final List<InternetAddress> result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        res = true;
      }
    } on SocketException catch (_) {
      res = false;
    }

    return res;
  }
}
NetworkManager getManager() => NetworkCheck();
