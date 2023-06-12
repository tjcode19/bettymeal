import 'MealResponse.dart';

class GetTimetable {
  String? code;
  String? message;
  List<GetTimetableData>? data;

  GetTimetable({this.code, this.message, this.data});

  GetTimetable.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetTimetableData>[];
      json['data'].forEach((v) {
        data!.add(new GetTimetableData.fromJson(v));
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

class GetTimetableData {
  String? sId;
  String? owner;
  String? startDate;
  String? endDate;
  bool? active;
  GetTimetableSub? sub;
  List<Timetable>? timetable;
  int? iV;

  GetTimetableData(
      {this.sId,
      this.owner,
      this.startDate,
      this.endDate,
      this.active,
      this.sub,
      this.timetable,
      this.iV});

  GetTimetableData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    active = json['active'];
    sub = json['sub'] != null ? new GetTimetableSub.fromJson(json['sub']) : null;
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

class GetTimetableSub {
  String? sId;
  String? name;
  int? duration;
  int? price;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? reshuffle;

  GetTimetableSub(
      {this.sId,
      this.name,
      this.duration,
      this.price,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.reshuffle});

  GetTimetableSub.fromJson(Map<String, dynamic> json) {
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
  MealData? meal;
  String? sId;

  Meals({this.date, this.category, this.meal, this.sId});

  Meals.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    category = json['category'];
    meal = json['meal'] != null ? new MealData.fromJson(json['meal']) : null;
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

// class Meal {
//   String? sId;
//   String? name;
//   String? description;
//   List<String>? category;
//   List<String>? extra;
//   List<String>? nutrients;
//   String? country;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   Meal(
//       {this.sId,
//       this.name,
//       this.description,
//       this.category,
//       this.extra,
//       this.nutrients,
//       this.country,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   Meal.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     description = json['description'];
//     category = json['category'].cast<String>();
//     extra = json['extra'].cast<String>();
//     nutrients = json['nutrients'].cast<String>();
//     country = json['country'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['extra'] = this.extra;
//     data['nutrients'] = this.nutrients;
//     data['country'] = this.country;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
