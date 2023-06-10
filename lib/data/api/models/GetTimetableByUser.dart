class GetTimetableByUser {
  String? code;
  String? message;
  TableUserData? data;

  GetTimetableByUser({this.code, this.message, this.data});

  GetTimetableByUser.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new TableUserData.fromJson(json['data']) : null;
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

class TableUserData {
  String? sId;
  String? owner;
  String? startDate;
  String? endDate;
  List<Timetable>? timetable;
  int? iV;

  TableUserData(
      {this.sId,
      this.owner,
      this.startDate,
      this.endDate,
      this.timetable,
      this.iV});

  TableUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    startDate = json['startDate'];
    endDate = json['endDate'];
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
    if (this.timetable != null) {
      data['timetable'] = this.timetable!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Timetable {
  String? day;
  List<Meals>? meals;
  String? sId;

  Timetable({this.day, this.meals, this.sId});

  Timetable.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Meals {
  String? date;
  String? category;
  Meal? meal;
  String? sId;

  Meals({this.date, this.category, this.meal, this.sId});

  Meals.fromJson(Map<String, dynamic> json) {
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
