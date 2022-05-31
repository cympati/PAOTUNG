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
    try {
      Response response = await dio.get(apiEndPoint + '/profile/info');
      UserResponse userResponse = UserResponse.fromJson(response.data);
      return userResponse.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
  }

  static Future<dynamic> updateProfile(
      {required String email,
      required String username,
      required String password,
      File? file,
      String? defaultImage}) async {
    var fileName = null;
    var updatedFile = null;

    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      if (file != null) {
        fileName = file.path.split('/').last;
        updatedFile = (await MultipartFile.fromFile(file.path, filename: fileName)).filename;
        Response response = await Dio().patch(apiEndPoint + '/profile/update',
            data: {
              "email": email,
              "user_name": username,
              "password": password,
              "path_profile_picture": updatedFile
            },
            options: Options(headers: {"Authorization": "Bearer " + userToken!}));
        InfoResponse res = InfoResponse.fromJson(response.data);
        return res;
      }
      Response response = await Dio().patch(apiEndPoint + '/profile/update',
          data: {
            "email": email,
            "user_name": username,
            "password": password,
            "path_profile_picture": defaultImage
          },
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      InfoResponse res = InfoResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }
}
