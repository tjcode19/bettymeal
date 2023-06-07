class SendOtp {
  String? code;
  String? message;
  Data? data;

  SendOtp({this.code, this.message, this.data});

  SendOtp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? otp;
  String? userId;

  Data({this.otp, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['userId'] = this.userId;
    return data;
  }
}
