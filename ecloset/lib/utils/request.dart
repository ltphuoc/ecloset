import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ecloset/Utils/routes_name.dart';
import 'package:ecloset/Widgets/custom_dialog.dart';
import 'package:ecloset/api/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as Get;

Map<String, dynamic> convertToQueryParams(
    [Map<String, dynamic> params = const {}]) {
  Map<String, dynamic> queryParams = Map.from(params);
  return queryParams.map<String, dynamic>(
    (key, value) => MapEntry(
        key,
        value == null
            ? null
            : (value is List)
                ? value.map<String>((e) => e.toString()).toList()
                : value.toString()),
  );
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ExpiredException extends AppException {
  ExpiredException([String? message]) : super(message, "Token Expired: ");
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'REQUEST[${options.method}] => PATH: ${options.path} HEADER: ${options.headers.toString()}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }
    if (kDebugMode) {
      print('DATA: ${response.data}');
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    }
    return super.onError(err, handler);
  }
}
// or new Dio with a BaseOptions instance.

class MyRequest {
  static BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        Headers.contentTypeHeader: "application/json",
      },
      sendTimeout: 15000,
      receiveTimeout: 5000);
  late Dio _inner;
  MyRequest() {
    _inner = Dio(options);
    // _inner.interceptors.add(
    //     DioCacheManager(CacheConfig(baseUrl: options.baseUrl)).interceptor);
    _inner.interceptors.add(CustomInterceptors());
    _inner.interceptors.add(InterceptorsWrapper(
      onResponse: (e, handler) {
        return handler.next(e); // continue
      },
      onError: (e, handler) async {
        if (kDebugMode) {
          print(e.response.toString());
        }
        if (e.response?.statusCode == 401) {
          const CustomDialogBox(
            title: "Vui lòng đăng nhập lại",
          );
          // await showStatusDialog("assets/images/global_error.png", "Lỗi",
          //     "Vui lòng đăng nhập lại");
          Get.Get.offAllNamed(RouteName.login);
        } else {
          handler.next(e);
        }
      },
    ));
  }

  Dio get request {
    return _inner;
  }

  set setToken(token) {
    options.headers["Authorization"] = "Bearer $token";
  }
}

final requestObj = MyRequest();
final request = requestObj.request;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
