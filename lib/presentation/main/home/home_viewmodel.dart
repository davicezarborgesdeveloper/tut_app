import 'dart:async';
import 'dart:ffi';

import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecase/home_usecase.dart';
import '../../base/base_view_model.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  HomeViewModel(this._homeUseCase);

  // inputs
  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputBanners.add(homeObject.data.banners);
      inputServices.add(homeObject.data.services);
      inputStores.add(homeObject.data.stores);
    });
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputServices => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  // outputs
  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

mixin HomeViewModelInputs {
  Sink get inputStores;

  Sink get inputServices;

  Sink get inputBanners;
}

mixin HomeViewModelOutputs {
  Stream<List<Store>> get outputStores;

  Stream<List<Service>> get outputServices;

  Stream<List<BannerAd>> get outputBanners;
}
