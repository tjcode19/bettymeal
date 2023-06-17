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
  SubInfo? subInfo;

  UserData(
      {this.sId,
      this.firstName,
      this.lastName,
      this.otp,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.subInfo});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    otp = json['otp'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    subInfo = json['subInfo'] != null ? new SubInfo.fromJson(json['subInfo']) : null;
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
    if (this.subInfo != null) {
      data['sub'] = this.subInfo!.toJson();
    }
    return data;
  }
}

class SubInfo {
  String? expiryDate;
  SubscriptionData? sub;
  String? sId;

  SubInfo({this.expiryDate, this.sub, this.sId});

  SubInfo.fromJson(Map<String, dynamic> json) {
    expiryDate = json['expiryDate'];
    sub = json['sub'] != null ? new SubscriptionData.fromJson(json['sub']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiryDate'] = this.expiryDate;
    if (this.sub != null) {
      data['sub'] = this.sub!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}


