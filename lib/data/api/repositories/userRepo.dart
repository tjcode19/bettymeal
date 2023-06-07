import 'package:bettymeals/data/api/models/SendOtp.dart';
import 'package:bettymeals/data/api/models/User.dart';
import 'package:bettymeals/data/api/models/VerifyEmail.dart';
import 'package:bettymeals/data/api/network_request.dart';

class UserRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<bool> finishSplashScreen() async {
    return false;
  }

  // Future<GetTokenApi?> login(LoginRequest login) async {
  //   final apiCall = await networkService?.login(login);
  //   return GetTokenApi.fromJson(apiCall);
  // }

  // Future<GuestLoginModel?> guestLogin() async {
  //   final apiCall = await networkService?.guestLogin();
  //   return GuestLoginModel.fromJson(apiCall);
  // }

  // Future<UserRegister> registerUser(UsersModel user) async {
  //   final apiCall = await networkService?.registerUser(user);
  //   return UserRegister.fromJson(apiCall);
  // }

  // Future<dynamic> login(LoginRequest login) async {
  //   final response = await apiProvider.postBasicAuth(
  //     "actions/login",
  //     {},
  //     '${login.email}:${login.password}',
  //   );

  //   return {'responseCode': '00', 'responseData': response};
  // }

  // Future<dynamic> guestLogin({String postcode = "3000"}) async {
  //   try {
  //     final response = await apiProvider.post(
  //       "actions/guest-login",
  //       {"postcode": postcode},
  //     );

  //     return {'responseCode': '00', 'responseData': response};
  //   } catch (e) {}
  // }

  Future<UserRegistration> registerUser(email) async {
    final response = await nRequest.post(
      "user/",
      {
        "email": email,
      },
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
}
