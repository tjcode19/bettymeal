import 'GetSubscription.dart';

class GetUserDetails {
  String? code;
  String? message;
  UserData? data;

  GetUserDetails({this.code, this.message, this.data});

  GetUserDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  String? sId;
  String? firstName;
  String? lastName;
  String? otp;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;
  SubscriptionData? sub;

  UserData(
      {this.sId,
      this.firstName,
      this.lastName,
      this.otp,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.sub});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    otp = json['otp'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    sub = json['sub'] != null ? new SubscriptionData.fromJson(json['sub']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['otp'] = this.otp;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.sub != null) {
      data['sub'] = this.sub!.toJson();
    }
    return data;
  }
}


