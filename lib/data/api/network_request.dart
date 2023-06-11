import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import '../../utils/enums.dart';
import '../CustomException.dart';
import '../shared_preference.dart';

// import 'CustomException.dart';

class NetworkRequest {
  final String _baseUrl = "https://mealbleapi-production.up.railway.app/";

  final SharedPreferenceApp? _sharedPreferenceQS = SharedPreferenceApp();

  final kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';

  String? token;
  Map<String, String>? headers;
  Map<String, String>? headerLogin;
  var timeOut = 60;

  getTokenPref() async {
    try {
      token = _sharedPreferenceQS!
          .getSharedPrefs(sharedType: SpDataType.String, fieldName: 'token');
    } catch (e) {
      print(e);
    }

    headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    await getTokenPref();
    final uri = Uri.parse(_baseUrl + url);

    print('the uri: $uri');
    try {
      final response = await http.get(uri, headers: headers);

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {
      throw UnauthorisedException('Token Expired');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    await getTokenPref();

    final uri = Uri.parse(_baseUrl + url);

    print('the uri: $uri');

    try {
      final response = await http.delete(uri, headers: headers);
      inspect(response);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on UnauthorisedException {
      throw UnauthorisedException('Token Expired');
    }
    return responseJson;
  }

  Future<dynamic> getBasicAuth(String url, authN) async {
    var responseJson;
    // await getTokenPref();
    var auth = 'Basic ${base64Encode(utf8.encode(authN))}';
    final uri = Uri.parse(_baseUrl + url);
    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": auth
        },
      );

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> post(String url, Map body) async {
    var responseJson;
    await getTokenPref();
    try {
      final uri = Uri.parse(_baseUrl + url);

      print('the uri: $uri');
      print(jsonEncode(body));

      final response = await http
          .post(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: jsonEncode(body),
      )
          .timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          // return null;
          throw TimeoutException('Time out');
        },
      );

      responseJson = _response(response);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> postToken(String url, Map body) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await http
          .post(Uri.parse(_baseUrl + url),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                "Accept": "application/json",
              },
              body: body,
              encoding: Encoding.getByName("utf-8"))
          .timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          throw TimeoutException('Time out');
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> postBasicAuth(
      String url, Map body, var authN) async {
    var responseJson;
    await getTokenPref();
    var auth = 'Basic ${base64Encode(utf8.encode(authN))}';
    try {
      final response = await http
          .post(
        Uri.parse(_baseUrl + url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": auth
        },
        body: jsonEncode(body),
      )
          .timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          throw TimeoutException('Time out');
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Map body) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await http
          .put(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: jsonEncode(body),
      )
          .timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          print('Time out');
          // return null;
          throw TimeoutException('Time out');
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, Map body) async {
    var responseJson;
    await getTokenPref();
    try {
      final response = await http
          .patch(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: jsonEncode(body),
      )
          .timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          print('Time out');
          // return null;
          throw TimeoutException('Time out');
        },
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>?> uploadFile(File image, String url,
      String fileType, String docName, String actionType) async {
    print(url);

    await getTokenPref();
    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])!.split('/');
    // Intilize the multipart request
    final imageUploadRequest =
        http.MultipartRequest(actionType, Uri.parse(_baseUrl + url));
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath(docName, image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.fields['type'] = fileType;
    //imageUploadRequest.headers.addAll(headers);
    imageUploadRequest.files.add(file);

    imageUploadRequest.headers[HttpHeaders.authorizationHeader] =
        'Bearer $token';
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse).timeout(
        Duration(seconds: timeOut),
        onTimeout: () {
          print('Time out');
          // return null;
          throw TimeoutException('Time out');
        },
      );

      var responseData = _response(response);
      // if (response.statusCode != 200) {
      //   return null;
      // }
      //final Map<String, dynamic> responseData = json.decode(response.body);
      //_resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  dynamic _response(http.Response response) {
    // var tokenExp =
    //     jsonEncode({"response_code": "06", 'response_description': 'Failed'});

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // log('ApiProdider200: $responseJson');
        return responseJson;

      case 201:
        var responseJson = json.decode(response.body.toString());
        // log('ApiProdider201: $responseJson');
        return responseJson;

      case 401:
        var responseJson = json.decode(response.body.toString());
        log('ApiProdider401: $responseJson');
        return responseJson;

      default:
        var responseJson = json.decode(response.body.toString());
        log('ApiProdiderDefault: $responseJson ${response.statusCode}');
        return responseJson;
    }
  }
}
