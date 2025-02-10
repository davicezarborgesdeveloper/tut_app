// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(
    this.email,
    this.password,
    this.imei,
    this.deviceType,
  );
}

class RegisterRequest {
  String countryMobileCode;
  String userName;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;
  RegisterRequest(
    this.countryMobileCode,
    this.userName,
    this.email,
    this.password,
    this.mobileNumber,
    this.profilePicture,
  );
}
