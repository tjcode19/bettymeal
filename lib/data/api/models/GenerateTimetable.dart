class GenerateTimetable {
  String? code;
  String? message;

  GenerateTimetable({this.code, this.message});

  GenerateTimetable.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
