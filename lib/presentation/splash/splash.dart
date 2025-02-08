import 'dart:async';

import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    NavigatorState navigator = Navigator.of(context);
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              navigator.pushReplacementNamed(Routes.mainRoute),
            }
          else
            {
              _appPreferences.isOnboardingScreenViewed().then(
                    (isOnBoardingScreenViewed) => {
                      if (isOnBoardingScreenViewed)
                        {
                          navigator.pushReplacementNamed(Routes.loginRoute),
                        }
                      else
                        {
                          navigator
                              .pushReplacementNamed(Routes.onBoardingRoute),
                        }
                    },
                  ),
            }
        });
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
