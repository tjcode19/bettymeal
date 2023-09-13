class NotiResponse {
  String? title;
  String? body;
  String? date;

  NotiResponse({this.title, this.body, this.date});

  NotiResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['body'] = this.body;
    data['date'] = this.date;
    return data;
  }
}
