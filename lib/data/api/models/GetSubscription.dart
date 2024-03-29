class GetSubscription {
  String? code;
  String? message;
  List<SubscriptionData>? data;

  GetSubscription({this.code, this.message, this.data});

  GetSubscription.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubscriptionData>[];
      json['data'].forEach((v) {
        data!.add(new SubscriptionData.fromJson(v));
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

class SubscriptionData {
  String? sId;
  String? name;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Period? period;

  SubscriptionData(
      {this.sId,
      this.name,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.period});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
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
  String? playId;
  String? appleId;

  Week({this.id, this.duration, this.price, this.shuffle, this.regenerate, this.playId, this.appleId});

  Week.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    price = json['price'];
    shuffle = json['shuffle'];
    regenerate = json['regenerate'];
    playId = json['playId'];
    appleId = json['appleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['shuffle'] = this.shuffle;
    data['regenerate'] = this.regenerate;
    data['playId'] = this.playId;
    data['appleId'] = this.appleId;
    return data;
  }
}
