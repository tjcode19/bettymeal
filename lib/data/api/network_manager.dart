import 'network_check_manager.dart'
    if (dart.library.io) 'network_check.dart'
    if (dart.library.html) 'network_check_web.dart';


abstract class NetworkManager{

  static NetworkManager? _instance;

  static NetworkManager get instance {
    _instance ??= getManager();
    return instance;
  }

  Future<bool> isConnected();
}