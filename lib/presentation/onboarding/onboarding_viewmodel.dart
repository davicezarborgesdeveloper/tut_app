import 'dart:async';

import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';

import '../resources/assets_manager.dart';
import '../resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  // scream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

// inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // sent this slider data to our vire
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++; // +1
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider list
    }
    return _currentIndex;
  }

  @override
  void onPageChange(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputsliderViewObject => _streamController.sink;

  // outputS
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

// private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onboardingTitle1,
            AppStrings.onboardingsubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onboardingTitle2,
            AppStrings.onboardingsubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onboardingTitle3,
            AppStrings.onboardingsubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onboardingTitle4,
            AppStrings.onboardingsubTitle4, ImageAssets.onboardingLogo4),
      ];
  _postDataToView() {
    inputsliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs mean the orders that our view model will recieve from our view
mixin OnboardingViewModelInputs {
  void goNext(); // whe user clicks on right arrow or swipe.
  void goPrevious(); // whe user clocks on left arrow of swipe right.
  void onPageChange(int index);

  Sink
      get inputsliderViewObject; // this is the way to add data to the scream .. stream input
}

// outputs mean data or result that will be sent from our view model to our view
mixin OnboardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(
    this.sliderObject,
    this.numOfSlides,
    this.currentIndex,
  );
}
