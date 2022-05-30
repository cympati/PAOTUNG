import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/config/api.dart';
import 'package:paotung_frontend/core/data/models/error/error_response.dart';
import 'package:paotung_frontend/core/data/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUser {
  static Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user');
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer " + (token ?? " ");
    Response response = await dio.get(apiEndPoint + '/profile/info');
    UserResponse userResponse = UserResponse.fromJson(response.data);
    return userResponse.data;
  }


  // อย่าลืมกลับมาแก้
  static Future<dynamic> updateProfile(
      {required String email,
      required String username,
      required String password,
      File? file}) async {
    var fileName = null;
    var updatedFile = null;
    debugPrint(file.toString());
    if (file != null) {
      fileName = file.path.split('/').last;
      updatedFile = (await MultipartFile.fromFile(file.path, filename: fileName)).filename;
      debugPrint(fileName);
      debugPrint(updatedFile);

    }
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      debugPrint("test image 2");

      Response response = await Dio().patch(apiEndPoint + '/profile/update',
          data: {
            "email": email,
            "user_name": username,
            "password": password,
            "path_profile_picture": updatedFile
          },
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      debugPrint(response.data.toString());
      InfoResponse res = InfoResponse.fromJson(response.data);
      if (res.success) {
        return res;
      } else if (res is ErrorResponse) {
        var error = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(left: 15, right: 15),
          content: Text(res.code),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        // ScaffoldMessenger.of(context).showSnackBar(error);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

//   static Future<dynamic> changeImage(File file) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? userToken = prefs.getString('user');
//     String fileName = file.path.split('/').last;
//     FormData formData = FormData.fromMap({
//       "path_profile_picture": await MultipartFile.fromFile(file.path, filename: fileName),
//     });
//     try {
//       Response response = await Dio().patch(
//           apiEndPoint + '/profile/',
//           data: formData,
//           options: Options(headers: {"Authorization": "Bearer " + userToken!}));
//       InfoResponse res = InfoResponse.fromJson(response.data);
//       return res;
//     } on DioError catch (e) {
//       if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
//         ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
//         return error;
//       }
//     }
//     return "";
//   }
}
