import 'package:bettymeals/data/api/models/GetSubscription.dart';
import 'package:bettymeals/data/api/network_request.dart';

class SubRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<GetSubscription> getSubscription() async {
    final response = await nRequest.get("subscription");

    return GetSubscription.fromJson(response);
  }
}
