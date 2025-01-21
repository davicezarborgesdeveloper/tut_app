import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel =
      LoginViewModel(null); // todo pass here login user case

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SvgPicture.asset(ImageAssets.loginIc),
                const Image(
                  image: AssetImage(ImageAssets.splashLogo),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: AppStrings.userName,
                            labelText: AppStrings.userName,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.userNameError,
                          ),
                        );
                      }),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError,
                          ),
                        );
                      }),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder(
                      stream: _viewModel.outputIsAllInputValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.login();
                                    }
                                  : null,
                              child: const Text(AppStrings.login)),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        },
                        child: Text(
                          AppStrings.register,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
