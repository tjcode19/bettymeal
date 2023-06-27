import 'package:bettymeals/data/api/models/GetSubscription.dart';

import 'GetTimetable.dart';

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
  User? user;
  List<ActiveSub>? activeSub;
  bool? isFreshUser;

  UserData({this.user, this.activeSub, this.isFreshUser});

  UserData.fromJson(Map<String, dynamic> json) {
     isFreshUser = json['isFreshUser'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['activeSub'] != null) {
      activeSub = <ActiveSub>[];
      json['activeSub'].forEach((v) {
        activeSub!.add(new ActiveSub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isFreshUser'] = this.isFreshUser;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.activeSub != null) {
      data['activeSub'] = this.activeSub!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? otp;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.otp,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    otp = json['otp'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    return data;
  }
}

class ActiveSub {
  String? sId;
  String? owner;
  String? startDate;
  String? endDate;
  bool? active;
  SubscriptionData? sub;
  List<Timetable>? timetable;
  int? iV;

  ActiveSub(
      {this.sId,
      this.owner,
      this.startDate,
      this.endDate,
      this.active,
      this.sub,
      this.timetable,
      this.iV});

  ActiveSub.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    active = json['active'];
    sub = json['sub'] != null ? new SubscriptionData.fromJson(json['sub']) : null;
    if (json['timetable'] != null) {
      timetable = <Timetable>[];
      json['timetable'].forEach((v) {
        timetable!.add(new Timetable.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['owner'] = this.owner;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['active'] = this.active;
    if (this.sub != null) {
      data['sub'] = this.sub!.toJson();
    }
    if (this.timetable != null) {
      data['timetable'] = this.timetable!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

