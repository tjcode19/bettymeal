import 'package:bettymeals/data/api/models/LoginResponse.dart';
import 'package:bettymeals/data/api/models/SendOtp.dart';
import 'package:bettymeals/data/api/models/SetPassword.dart';
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

  Future<LoginResponse> login(email, password) async {
    final response = await nRequest.post(
      "auth",
      {"email": email, "password": password},
    );

    return LoginResponse.fromJson(response);
  }

  Future<LoginResponse> changePassword(oldPass, newPass) async {
    final response = await nRequest.post(
      "auth/change-password",
      {"currentPassword": oldPass, "newPassword": newPass},
    );

    return LoginResponse.fromJson(response);
  }

  Future<SetPassword> setPassword(pass, userId, otp) async {
    final response = await nRequest.patch(
      "auth/set-password/$userId",
      {"password": pass, "otp": otp},
    );

    return SetPassword.fromJson(response);
  }
}
