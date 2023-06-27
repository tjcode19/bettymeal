import 'dart:html' as html;

import 'network_manager.dart';

class NetworkCheckWeb extends NetworkManager {
  @override
  Future<bool> isConnected() async {
    bool res = false;

    final bool con = html.window.navigator.onLine ?? false;
    if (con) {
      res = true;
    }

    return res;
  }
}

NetworkManager getManager() => NetworkCheckWeb();
