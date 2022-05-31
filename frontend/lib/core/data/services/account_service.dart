import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paotung_frontend/config/api.dart';
import '../models/account/account_response.dart';
import '../models/error/error_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  static Future<dynamic> login(String email, String password) async {
    print(email);
    print( password);
    try {
      Response response =
          await Dio().post(apiEndPoint + '/account/login', data: {
        'email': email,
        'password': password,
      });
      LoginResponse res = LoginResponse.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', res.token);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorStartResponse error =
            ErrorStartResponse.fromJson(e.response?.data);
        return error;
      }
    }
  }

  static Future<dynamic> register(
      String email, String username, String password) async {
    try {
      Response response =
          await Dio().post(apiEndPoint + '/account/register', data: {
        'email': email,
        'user_name': username,
        'password': password,
      });
      LoginResponse res = LoginResponse.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', res.token);
      return true;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorStartResponse error =
            ErrorStartResponse.fromJson(e.response?.data);
        return error;
      }
    }
  }
}
