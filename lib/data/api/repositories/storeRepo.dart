import 'package:bettymeals/data/api/models/GetStoreItems.dart';
import 'package:bettymeals/data/api/network_request.dart';

class StoreRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<GetStoreItems> getStoreItems() async {
    final response = await nRequest.get("store");

    return GetStoreItems.fromJson(response);
  }
}
