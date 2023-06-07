class GetAllMeal {
  String? code;
  String? message;
  List<MealData>? data;

  GetAllMeal({this.code, this.message, this.data});

  GetAllMeal.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MealData>[];
      json['data'].forEach((v) {
        data!.add(new MealData.fromJson(v));
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

class MealData {
  String? sId;
  String? name;
  List<String>? category;
  String? country;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MealData(
      {this.sId,
      this.name,
      this.category,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.iV});

  MealData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    category = json['category'].cast<String>();
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
