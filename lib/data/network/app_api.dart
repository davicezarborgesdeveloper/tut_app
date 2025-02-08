import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../app/constant.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String imei,
    @Field("deviceType") String deviceType,
  );

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);
}

abstract class ParseErrorLogger {
  void logError(
      Object error, StackTrace stackTrace, RequestOptions requestOptions);
}
