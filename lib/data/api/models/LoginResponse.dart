class LoginResponse {
  String? code;
  String? message;
  LoginData? data;

  LoginResponse({this.code, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginData {
  String? token;
  String? tokenExp;
  bool? activeSub;
  String? email;
  String? userId;
  String? otp;

  LoginData(
      {this.token,
      this.tokenExp,
      this.activeSub,
      this.email,
      this.userId,
      this.otp});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenExp = json['tokenExp'];
    activeSub = json['activeSub'];
    email = json['email'];
    userId = json['userId'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['tokenExp'] = this.tokenExp;
    data['activeSub'] = this.activeSub;
    data['email'] = this.email;
    data['userId'] = this.userId;
    data['otp'] = this.otp;
    return data;
  }
}
