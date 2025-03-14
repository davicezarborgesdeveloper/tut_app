import 'dart:convert';

import 'package:complete_advanced_flutter/app/app_prefs.dart';
import 'package:complete_advanced_flutter/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60 * 1000; // 1 min
    String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constant.token,
      defaultLanguage: language
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(milliseconds: timeOut),
      receiveTimeout: Duration(milliseconds: timeOut),
      headers: headers,
    );

    if (kReleaseMode) {
      debugPrint("release mode no logs");
    } else {
      dio.interceptors.add(
        InterceptorsWrapper(
          onResponse: (Response response, ResponseInterceptorHandler handler) {
            if (response.data.runtimeType == String) {
              response.data = jsonDecode(response.data);
            }
            return handler.next(response);
          },
        ),
      );
      // dio.interceptors.add(LogInterceptor(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseBody: true,
      //   responseHeader: true,
      // ));
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }

    return dio;
  }
}
