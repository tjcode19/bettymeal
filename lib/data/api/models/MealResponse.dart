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
  String? imageUrl;
  List<String>? category;
  String? country;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<String>? extra;
  List<String>? nutrients;
  List<String>? ingredients;
  List<String>? guides;
  List<String>? tribe;
  String? description;

  MealData(
      {this.sId,
      this.name,
      this.imageUrl,
      this.category,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.extra,
      this.nutrients,
      this.ingredients,
      this.guides,
      this.tribe,
      this.description});

  MealData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    category = json['category'].cast<String>();
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    extra = json['extra']?.cast<String>();
    nutrients = json['nutrients']?.cast<String>();
    ingredients = json['ingredients']?.cast<String>();
    guides = json['guides']?.cast<String>();
    tribe = json['tribe']?.cast<String>();
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['category'] = this.category;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['extra'] = this.extra;
    data['nutrients'] = this.nutrients;
    data['ingredients'] = this.ingredients;
    data['guides'] = this.guides;
    data['tribe'] = this.tribe;
    data['description'] = this.description;
    return data;
  }
}
