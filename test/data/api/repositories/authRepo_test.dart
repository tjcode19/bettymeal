import 'package:bettymeals/data/api/models/LoginResponse.dart';
import 'package:bettymeals/data/api/models/SendOtp.dart';
import 'package:bettymeals/data/api/repositories/authRepo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthRepository authRepository;
  setUp(() {
    authRepository = AuthRepository();
  });
  group('AuthRepository', () {
    group('Login', () {
      test(
        'Check Login',
        () async {
          //Arrange
          //Act
          final c = await authRepository.login('a4@a.com', 'pass');
          //Assert
          expect(c, isA<LoginResponse>());
        },
      );
    });

    group('send OTP', () {
      test(
        'Check Send OTP',
        () async {
          //Arrange
          //Act
          final c = await authRepository.sendOtp('a4@a.com');
          //Assert
          expect(c, isA<SendOtp>());
        },
      );
    });
  });
}
