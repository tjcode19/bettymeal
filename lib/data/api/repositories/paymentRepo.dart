import 'package:bettymeals/data/api/models/LoginResponse.dart';
import 'package:bettymeals/data/api/models/SendOtp.dart';
import 'package:bettymeals/data/api/network_request.dart';

class PaymentRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<SendOtp> makePayment(email) async {
    final response = await nRequest.post(
      "auth/send-otp/",
      {"email": email},
    );

    return SendOtp.fromJson(response);
  }

  Future<LoginResponse> getPaymentStatus(email, password) async {
    final response = await nRequest.post(
      "auth",
      {"email": email, "password": password},
    );

    return LoginResponse.fromJson(response);
  }
}
