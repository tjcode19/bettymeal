import 'package:bettymeals/data/api/models/GetNotifications.dart';
import 'package:bettymeals/data/api/network_request.dart';

class NotiRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<GetNotifications> getAllNotifications() async {
    final response = await nRequest.get("notification/messages");

    return GetNotifications.fromJson(response);
  }

  Future<GetNotifications> getTips({name}) async {
    final response = await nRequest.get("notification/tips");

    return GetNotifications.fromJson(response);
  }
}
