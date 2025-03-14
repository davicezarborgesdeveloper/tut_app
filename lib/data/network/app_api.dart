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

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("country_mobile_code") String countryMobileCode,
    @Field("user_name") String userName,
    @Field("email") String email,
    @Field("password") String password,
    @Field("mobile_number") String mobileNumber,
    @Field("profile_picture") String profilePicture,
  );

  @GET("/home")
  Future<HomeResponse> getHome();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> getStoreDetails();
}

abstract class ParseErrorLogger {
  void logError(
      Object error, StackTrace stackTrace, RequestOptions requestOptions);
}
