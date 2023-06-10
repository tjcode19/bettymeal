class GetSubscription {
  String? code;
  String? message;
  List<SubData>? data;

  GetSubscription({this.code, this.message, this.data});

  GetSubscription.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubData>[];
      json['data'].forEach((v) {
        data!.add(new SubData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubData {
  String? sId;
  String? name;
  String? duration;
  String? price;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? reshuffle;

  SubData(
      {this.sId,
      this.name,
      this.duration,
      this.price,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.reshuffle});

  SubData.fromJson(Map<String, dynamic> json) {
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
