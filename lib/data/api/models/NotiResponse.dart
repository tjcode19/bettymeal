class NotiResponse {
  String? title;
  String? body;

  NotiResponse({this.title, this.body});

  NotiResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
