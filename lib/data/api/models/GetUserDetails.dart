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
  Sub? sub;

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
    sub = json['sub'] != null ? new Sub.fromJson(json['sub']) : null;
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

class Sub {
  String? sId;
  String? name;
  int? duration;
  double? price;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? reshuffle;

  Sub(
      {this.sId,
      this.name,
      this.duration,
      this.price,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.reshuffle});

  Sub.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    duration = json['duration'];
    price = json['price'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    reshuffle = json['reshuffle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['reshuffle'] = this.reshuffle;
    return data;
  }
}
