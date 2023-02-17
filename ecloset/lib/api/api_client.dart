import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
const baseUrl = "https://10.0.2.2:7269/api";

class Api_Client {
  late BuildContext context;
  final Dio _dio = Dio();
  //IMPLEMENT USER REIGSTER
  Future signup(
      String email, String password, String phone, String name) async {
    String urlPath = '$baseUrl/account/register';

    dynamic userDataSignin = {
      'contactLname': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
    try {
      var signUpResponse = await _dio.post(urlPath,
          data: userDataSignin,
          options: Options(
              headers: {'Content-type': 'application/json; charset=utf-8'}));

      return signUpResponse.data;
    } catch (e) {
      return e;
    }
  }

  //IMPLEMENT USER LOGIN
  Future login(String name, String password, String newPassword) async {
    const urlPath = '$baseUrl/api/account/login';

    dynamic userData = {
      'email': name,
      'password': password,
      'newPassword': newPassword
    };
    var loginResponse = await _dio.post(urlPath,
        data: userData,
        options: Options(
            headers: {'Content-type': 'application/json; charset=utf-8'}));

    try {
      var loginArr = loginResponse.data;
      print(loginArr['token']);
      return loginArr;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Processing Data"),
          backgroundColor: Colors.red.shade300));
      print('Error login');
    }
  }
}
