import 'dart:async';

import 'package:complete_advanced_flutter/domain/usecase/login_usercase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import 'package:complete_advanced_flutter/presentation/common/freezed_data.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  final LoginUserCase? _loginUserCase;

  LoginViewModel(this._loginUserCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputValidStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  login() async {
    // (await _loginUserCase?.execute(
    //         LoginUserCaseInput(loginObject.userName, loginObject.password)))!
    //     .fold((failure) => {}, (data) => {});
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin
    _validate();
  }

// outputs

  @override
  Stream<bool> get outputIsUserNameValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserPasswordValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream.map((_) => _isAllInputValid());

// private functions

  _validate() {
    inputIsAllInputValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

mixin LoginViewModelInputs {
  // three functions for actions
  setUserName(String userName);
  setPassword(String password);
  login();

  // two sinkjs for streams
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

mixin LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsUserPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}
