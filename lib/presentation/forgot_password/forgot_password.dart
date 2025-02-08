import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../common/state_renderer/state_renderer_impl.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/string_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  _bind() {
    _viewModel.start();
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.forgotPassword();
                  }) ??
                  _getContentWidget();
            })
        // body: _getContentWidget(),
        );
  }

  Widget _getContentWidget() {
    return Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(image: AssetImage(ImageAssets.splashLogo)),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsEmailValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: AppStrings.emailHint,
                              labelText: AppStrings.emailHint,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.invalidEmail),
                        );
                      }),
                ),
                const SizedBox(height: AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllInputValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () => _viewModel.forgotPassword()
                                  : null,
                              child: const Text(AppStrings.resetPassword)),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
