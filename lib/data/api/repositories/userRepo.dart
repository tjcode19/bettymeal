import 'package:bettymeals/data/api/models/User.dart';
import 'package:bettymeals/data/api/models/VerifyEmail.dart';
import 'package:bettymeals/data/api/network_request.dart';

import '../models/GetUserDetails.dart';

class UserRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<bool> finishSplashScreen() async {
    return false;
  }

  Future<UserRegistration> registerUser(email) async {
    final response = await nRequest.post(
      "user/",
      {
        "email": email,
      },
    );

    return UserRegistration.fromJson(response);
  }

  Future<UserRegistration> updateUser(query) async {
    final response = await nRequest.patch(
      "user/",
      query,
    );

    return UserRegistration.fromJson(response);
  }

  Future<VerifyEmail> verifyEmail(otp, password, userId) async {
    final response = await nRequest.post(
      "user/verify/",
      {"otp": otp, "password": password, "userId": userId},
    );

    return VerifyEmail.fromJson(response);
  }

  Future<GetUserDetails> getUserDetails() async {
    final response = await nRequest.get(
      "user/single",
    );

    return GetUserDetails.fromJson(response);
  }
}
