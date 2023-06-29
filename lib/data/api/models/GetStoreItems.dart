class GetStoreItems {
  String? code;
  String? message;
  List<StoreData>? data;

  GetStoreItems({this.code, this.message, this.data});

  GetStoreItems.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoreData>[];
      json['data'].forEach((v) {
        data!.add(new StoreData.fromJson(v));
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

class StoreData {
  MealItem? mealItem;
  int? count;

  StoreData({this.mealItem, this.count});

  StoreData.fromJson(Map<String, dynamic> json) {
    mealItem = json['mealItem'] != null
        ? new MealItem.fromJson(json['mealItem'])
        : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mealItem != null) {
      data['mealItem'] = this.mealItem!.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class MealItem {
  String? date;
  String? category;
  Meal? meal;
  String? sId;

  MealItem({this.date, this.category, this.meal, this.sId});

  MealItem.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    category = json['category'];
    meal = json['meal'] != null ? new Meal.fromJson(json['meal']) : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['category'] = this.category;
    if (this.meal != null) {
      data['meal'] = this.meal!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Meal {
  String? sId;
  String? name;
  String? description;
  List<String>? category;
  List<String>? extra;
  List<String>? nutrients;
  String? country;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Meal(
      {this.sId,
      this.name,
      this.description,
      this.category,
      this.extra,
      this.nutrients,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Meal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    category = json['category'].cast<String>();
    extra = json['extra'].cast<String>();
    nutrients = json['nutrients'].cast<String>();
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category'] = this.category;
    data['extra'] = this.extra;
    data['nutrients'] = this.nutrients;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
