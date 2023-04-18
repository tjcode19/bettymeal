import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enums.dart';


class SharedPreferenceApp {
  getSharedPrefs({SpDataType? sharedType, fieldName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(rem);

    switch (sharedType) {
      case SpDataType.String:
        var res = prefs.getString(fieldName);
        return res;
      case SpDataType.int:
        return prefs.getInt(fieldName);
      case SpDataType.bool:
        return prefs.getBool(fieldName);
      case SpDataType.double:
        return prefs.getDouble(fieldName);
      case SpDataType.object:
        final rawJson = prefs.getString(fieldName) ?? '{}';
        final map = jsonDecode(rawJson);
        return map;
      default:
        break;
    }
  }

  Future<void> setData({SpDataType? sharedType, fieldName, fieldValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (sharedType) {
      case SpDataType.String:
        prefs.setString(fieldName, fieldValue);
        break;
      case SpDataType.int:
        prefs.setInt(fieldName, fieldValue);
        break;
      case SpDataType.bool:
        prefs.setBool(fieldName, fieldValue);
        break;
      case SpDataType.double:
        prefs.setDouble(fieldName, fieldValue);
        break;
      case SpDataType.object:
        prefs.setString(fieldName, jsonEncode(fieldValue));
        break;
      default:
        break;
    }
  }

  clearSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }

  removeOnly(String fieldName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(fieldName);
  }
}
