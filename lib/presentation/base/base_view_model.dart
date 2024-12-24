abstract class BaseViewModel extends BaseViewModelInputs {
  // shared variables and functions that will be used through any view model.
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be calld when viewModel dies.
}

abstract class BaseViewModelOutputs {}
