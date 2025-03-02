// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:apps_consultation_pregnant/app/utils/service_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;

import '../modules/auth/views/auth_view.dart';
import 'base_url_utils.dart';
import 'log_utils.dart';

class ApiServices {
  static var client = http.Client();
  static final String _url = BaseUrl().getUrlDevice(); //base url rdl

  static Map<String, String> _setHeaders(String? token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future getNoToken(String endpoint) async {
    var response = await client.get(Uri.parse("$_url/$endpoint"));
    var encodeFirst = json.encode(response.body);
    return json.decode(response.body);
  }

  static Future getData(String endpoint) async {
    // Box box = Hive.box('user');

    String? token = ServicePreferences.getToken();

    var response = await client.get(Uri.parse("$_url/$endpoint"),
        headers: _setHeaders(token));
    try {
      log("response getdata: ${response.body}");

      if (response.statusCode > 499) {
        log(response.body);
        var message = json.decode(response.body);
        return Future.error(message);
      }
      if (json.decode(response.body)['message'] == 'jwt expired') {
        return Future.delayed(Duration.zero, () {
          ServicePreferences.clear();
          return Get.offAll(AuthView());
        });
      }
      return json.decode(response.body);
    } catch (e) {
      debugPrint("error getData -> $e");
      return null;
    }
  }

  static Future<dynamic> postData(
    String endpoint,
    Map<String, dynamic> params,
  ) async {
    String? token = ServicePreferences.getToken();
    try {
      var response = await client.post(Uri.parse("$_url/$endpoint"),
          headers: _setHeaders(token), body: jsonEncode(params));
      // if (response.statusCode == 400) {
      //   return Future.error(code400 ?? '');
      // }
      log("response post: ${response.statusCode}: ${params} ${response.body}");

      if (response.statusCode > 499) {
        return Future.error("Error occured, please try again later!");
      }
      LogUtil().debug(response.body);

      return json.decode(response.body);
    } catch (e) {
      log("error post : $e");
      debugPrint("error post data -> $e");
    }
  }

  static Future<dynamic> postDataWithoutToken(
    String endpoint,
    Map<String, dynamic> params,
  ) async {
    try {
      log("data params: ${Uri.parse("$_url/$endpoint")}, ${params}");
      var response = await client.post(Uri.parse("$_url/$endpoint"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(params));

      log("login data: ${response.statusCode}${response.body}");
      LogUtil().debug(response.body);
      if (response.statusCode > 499) {
        return Future.error(json.decode(response.body)['message']);
      }
      LogUtil().debug(response.body);

      return json.decode(response.body);
    } catch (e) {
      log("error post : $e");
      debugPrint("error post data -> $e");
    }
  }

  static Future<dynamic> postDataPath(
    String endpoint,
    Map<String, dynamic> params,
  ) async {
    // String? token = LocalStorageUtil.getToken();
    String token = '';
    try {
      var response = await client.post(Uri.parse("$_url/$endpoint"),
          headers: _setHeaders(token), body: json.encode(params));
      // if (response.statusCode == 400) {
      //   return Future.error(code400 ?? '');
      // }

      LogUtil().debug(response.body);
      if (response.statusCode > 499) {
        return Future.error("Error occured, please try again later!");
      }
      // LogUtil().debug(response.body);

      return json.decode(response.body);
    } catch (e) {
      log("error post : $e");
      debugPrint("error post data -> $e");
    }
  }

  static Future<dynamic> postDataWithoutBody(
    String endpoint,
  ) async {
    String token = '';
    // String? token = LocalStorageUtil.getToken();
    try {
      var response = await client.post(Uri.parse("$_url/$endpoint"),
          headers: _setHeaders(token), body: json.encode({}));
      // if (response.statusCode == 400) {
      //   return Future.error(code400 ?? '');
      // }

      LogUtil().debug(response.body);
      if (response.statusCode > 499) {
        return Future.error("Error occured, please try again later!");
      }
      LogUtil().debug(response.body);

      return json.decode(response.body);
    } catch (e) {
      log("error post : $e");
      debugPrint("error post data -> $e");
    }
  }

  static Future deleteData(String endpoint) async {
    // String? token = LocalStorageUtil.getToken();
    String token = '';
    var response = await client.delete(Uri.parse("$_url/$endpoint"),
        headers: _setHeaders(token));

    LogUtil().debug(response.body);
    return json.decode(response.body);
  }

  static Future logoutData(String endpoint) async {
    // String? token = LocalStorageUtil.getToken();
    String token = '';
    var response = await client.delete(Uri.parse("$_url/$endpoint"),
        headers: _setHeaders(token));

    LogUtil().debug(response.body);
  }

  static Future putData(String endpoint, Map<String, dynamic> params) async {
    // String? token = LocalStorageUtil.getToken();
    // Box box = Hive.box('user');
    // String token = box.get('token');
    String token = '';
    var response = await client.put(Uri.parse("$_url/$endpoint"),
        headers: _setHeaders(token), body: json.encode(params));
    log("response put data: ${response.statusCode}");
    if (response.statusCode > 499) {
      return Future.error("Error occured, please try again later!");
    }

    LogUtil().debug(response.body);
    return json.decode(response.body);
  }

  static Future<dynamic> postFile(
    String endpoint,
    String? imagePath,
    Map<String, dynamic>? otherParams, {
    String keyPhoto = 'signature',
  }) async {
    try {
      String? token = ServicePreferences.getToken();
      var request = http.MultipartRequest("POST", Uri.parse("$_url/$endpoint"));

      request.headers["Accept"] = 'multipart/form-data';
      request.headers["Authorization"] = 'Bearer $token';

      otherParams?.forEach((key, value) {
        request.fields[key] = value;
        log("dataku: ${key}, ${value}");
      });
      log('data me: $imagePath}');

      request.files
          .add(await http.MultipartFile.fromPath(keyPhoto, imagePath ?? ""));

      var rsp = await http.Response.fromStream(await request.send());
      log("response file: ${rsp.statusCode} ${rsp.body}");
      return json.decode(rsp.body);
    } on Exception catch (e) {
      LogUtil().errors("$e");
      return Future.error("$e");
    }
  }

// static Future exportFile(String endpoint) async {
//   Box box = Hive.box('user');
//
//   String token = box.get('token');
//   log("endpoint:${endpoint}");
//
//   var response = await client.get(Uri.parse("$_url/$endpoint"),
//       headers: _setHeaders(token));
//   log("response export: ${response.statusCode}");
//   try {
//     if (response.statusCode > 499) {
//       log(response.body);
//       var message = 'Error ExportFile';
//       return Future.error(message);
//     }
//     var data = response.bodyBytes;
//     return ExportPdfModel(
//       pdfData: data,
//       headers: response.headers,
//     );
//   } catch (e) {
//     debugPrint("error getData -> $e");
//     return null;
//   }
// }
}
