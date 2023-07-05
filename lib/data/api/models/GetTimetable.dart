import 'package:bettymeals/data/api/models/GetSubscription.dart';

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
  SubData? subData;
  SubscriptionData? sub;
  List<Timetable>? timetable;
  int? iV;

  GetTimetableData(
      {this.sId,
      this.owner,
      this.startDate,
      this.endDate,
      this.active,
      this.subData,
      this.sub,
      this.timetable,
      this.iV});

  GetTimetableData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = json['owner'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    active = json['active'];
    subData =
        json['subData'] != null ? new SubData.fromJson(json['subData']) : null;
    sub =
        json['sub'] != null ? new SubscriptionData.fromJson(json['sub']) : null;
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


