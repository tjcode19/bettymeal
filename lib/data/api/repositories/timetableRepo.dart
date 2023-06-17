import 'package:bettymeals/data/api/models/GenerateTimetable.dart';
import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:bettymeals/data/api/network_request.dart';

class TimetableRepo {
  final NetworkRequest nRequest = NetworkRequest();

  Future<GenerateTimetable> generateTimetable(subId, duration) async {
    final response = await nRequest.get("timetable/generate/$subId/$duration");

    return GenerateTimetable.fromJson(response);
  }

  Future<GenerateTimetable> shuffleTimetable(id) async {
    final response = await nRequest.get("timetable/shuffle/$id");

    return GenerateTimetable.fromJson(response);
  }

  Future<GetTimetable> getTimetable() async {
    final response = await nRequest.get("timetable/records");

    return GetTimetable.fromJson(response);
  }
}
