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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['activeSub'] != null) {
      activeSub = <ActiveSub>[];
      json['activeSub'].forEach((v) {
        activeSub!.add(new ActiveSub.fromJson(v));
      });
    }
    isFreshUser = json['isFreshUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.activeSub != null) {
      data['activeSub'] = this.activeSub!.map((v) => v.toJson()).toList();
    }
    data['isFreshUser'] = this.isFreshUser;
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? otp;
  String? email;
  List<String>? tribes;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? dob;
  String? gender;
  String? phoneNumber;
  bool? usedFree;

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.otp,
      this.email,
      this.tribes,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.dob,
      this.gender,
      this.phoneNumber,
      this.usedFree});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    otp = json['otp'];
    email = json['email'];
    tribes = json['tribes']?.cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    dob = json['dob'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    usedFree = json['usedFree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['otp'] = this.otp;
    data['email'] = this.email;
    data['tribes'] = this.tribes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['usedFree'] = this.usedFree;
    return data;
  }
}

class ActiveSub {
  String? sId;
  String? owner;
  String? startDate;
  String? endDate;
  bool? active;
  SubData? subData;
  Sub? sub;
  List<Timetable>? timetable;
  int? iV;

  ActiveSub(
      {this.sId,
      this.owner,
      this.startDate,
      this.endDate,
      this.active,
      this.subData,
      this.sub,
      this.timetable,
      this.iV});

  ActiveSub.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    active = json['active'];
    subData =
        json['subData'] != null ? new SubData.fromJson(json['subData']) : null;
    sub = json['sub'] != null ? new Sub.fromJson(json['sub']) : null;
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
    if (this.subData != null) {
      data['subData'] = this.subData!.toJson();
    }
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

class SubData {
  int? shuffle;
  int? regenerate;
  int? period;
  String? sId;

  SubData({this.shuffle, this.regenerate, this.period, this.sId});

  SubData.fromJson(Map<String, dynamic> json) {
    shuffle = json['shuffle'];
    regenerate = json['regenerate'];
    period = json['period'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shuffle'] = this.shuffle;
    data['regenerate'] = this.regenerate;
    data['period'] = this.period;
    data['_id'] = this.sId;
    return data;
  }
}

class Sub {
  String? sId;
  String? name;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Period? period;

  Sub(
      {this.sId,
      this.name,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.period});

  Sub.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    period =
        json['period'] != null ? new Period.fromJson(json['period']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.period != null) {
      data['period'] = this.period!.toJson();
    }
    return data;
  }
}

class Period {
  Week? week;
  Week? month;
  String? sId;

  Period({this.week, this.month, this.sId});

  Period.fromJson(Map<String, dynamic> json) {
    week = json['week'] != null ? new Week.fromJson(json['week']) : null;
    month = json['month'] != null ? new Week.fromJson(json['month']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.week != null) {
      data['week'] = this.week!.toJson();
    }
    if (this.month != null) {
      data['month'] = this.month!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Week {
  String? id;
  int? duration;
  int? price;
  int? shuffle;
  int? regenerate;

  Week({this.id, this.duration, this.price, this.shuffle, this.regenerate});

  Week.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    price = json['price'];
    shuffle = json['shuffle'];
    regenerate = json['regenerate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['shuffle'] = this.shuffle;
    data['regenerate'] = this.regenerate;
    return data;
  }
}

