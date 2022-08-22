import 'dart:async';

import 'package:app/res/R.dart';
import 'package:app/src/base/base_page.dart';
import 'package:app/src/page/forgot_password/forgot_password_cubit.dart';
import 'package:app/src/widgets/custom_appbar.dart';
import 'package:app/src/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordPage extends BasePage {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends BaseState<ForgotPasswordPage> {
  final ForgotPasswordCubit _forgotPasswordCubit = ForgotPasswordCubit();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";

  int pinCodeLength = 6;
  int? minutes = 1, seconds = 30;
  VoidCallback? onEnd;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(R.string.forgot_password),
      backgroundColor: R.color.white,
      body: BlocProvider(
        create: (context) => _forgotPasswordCubit,
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {
              debugPrint('Success: ${state.message}');
            } else if (state is ForgotPasswordFailure) {
              errorController!.add(ErrorAnimationType.shake);
              textEditingController.clear();
              debugPrint('Failure: ${state.message}');
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                ListView(
                  children: <Widget>[
                    _buildPageTitle,
                    _buildPinVerifycation,
                    _buildCountdown,
                  ],
                ),
                Visibility(
                  child: const LoadingWidget(),
                  visible: state is ForgotPasswordLoading,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget get _buildPageTitle => Padding(
        padding: EdgeInsets.all(30.h),
        child: Text(
          R.string.pin_code_verification.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80.sp),
          textAlign: TextAlign.center,
        ),
      );

  Widget get _buildPinVerifycation => Form(
        child: Padding(
          padding: EdgeInsets.all(30.h),
          child: PinCodeTextField(
            appContext: context,
            length: pinCodeLength,
            obscureText: true,
            obscuringCharacter: '*',
            blinkWhenObscuring: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: R.color.white,
              selectedFillColor: R.color.white,
              inactiveFillColor: R.color.white,
              activeColor: R.color.blue,
              selectedColor: R.color.blue,
              inactiveColor: R.color.red,
            ),
            cursorColor: R.color.black,
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            autoUnfocus: true,
            onCompleted: (value) {
              _forgotPasswordCubit.validatePin(value);
              debugPrint('Completed: $value');
            },
            onChanged: (value) {},
          ),
        ),
      );

  Widget get _buildCountdown => TweenAnimationBuilder<Duration>(
        duration: Duration(minutes: minutes ?? 0, seconds: seconds ?? 0),
        tween: Tween(
          begin: Duration(minutes: minutes ?? 0, seconds: seconds ?? 0),
          end: Duration.zero,
        ),
        onEnd: onEnd,
        builder: (BuildContext context, Duration value, Widget? child) => Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20.h),
          child: RichText(
            text: TextSpan(
              text: 'Countdown:',
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: R.color.black,
              ),
              children: [
                TextSpan(
                  text:
                      ' ${value.inMinutes.toString().padLeft(2, '0')}:${(value.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: value == Duration.zero ? R.color.red : R.color.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
