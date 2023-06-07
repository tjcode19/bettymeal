import 'package:bettymeals/data/api/models/SendOtp.dart';
import 'package:bettymeals/data/api/network_request.dart';

class AuthRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<SendOtp> sendOtp(email) async {
    final response = await nRequest.post(
      "auth/send-otp/",
      {"email": email},
    );

    return SendOtp.fromJson(response);
  }
}
