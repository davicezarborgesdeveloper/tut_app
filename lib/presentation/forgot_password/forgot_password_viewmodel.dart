import 'dart:async';

import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';

import '../../app/functions.dart';
import '../common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewmodel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewmodel(this._forgotPasswordUseCase);

  var email = "";

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() {
    // inputState.add(data);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  bool _isAllInputsValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

mixin ForgotPasswordViewModelInputs {
  forgotPassword();
  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

mixin ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
