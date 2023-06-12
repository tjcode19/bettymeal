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
  String? firstName;
  String? lastName;
  Sub? sub;
  String? userId;

  LoginData({this.token, this.firstName, this.lastName, this.sub, this.userId});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    sub = json['sub'] != null ? new Sub.fromJson(json['sub']) : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    if (this.sub != null) {
      data['sub'] = this.sub!.toJson();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class Sub {
  String? sId;
  String? name;
  int? duration;
  int? price;
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
