import 'package:app/res/R.dart';
import 'package:app/src/base/base_page.dart';
import 'package:app/src/page/sign_in/sign_in_cubit.dart';
import 'package:app/src/widgets/button_widget.dart';
import 'package:app/src/widgets/custom_appbar.dart';
import 'package:app/src/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/loading_widget.dart';
import '../forgot_password/forgot_password_page.dart';
import '../home/home_page.dart';

class SigninPage extends BasePage {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends BaseState<SigninPage> {
  final SignInCubit _signInCubit = SignInCubit();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.color.white,
      appBar: appBar(R.string.login),
      body: BlocConsumer<SignInCubit, SignInState>(
        bloc: _signInCubit,
        listener: (context, state) {
          if (state is SignInSuccess) {
            Fluttertoast.showToast(msg: R.string.login_success);
            pushScreen(const HomePage());
          } else if (state is SignInFailure) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          return buildPage(context, state);
        },
        buildWhen: (previous, current) => true,
      ),
    );
  }

  Widget buildPage(BuildContext context, SignInState state) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 50.h),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputEmail,
                  buildInputPassword,
                  buildForgetPassword,
                  buildSignInButton,
                  buildPageSubTitle,
                  buildLoginWithGoogle,
                  buildLoginWithFacebook,
                ],
              ),
            ),
          ),
          Visibility(
            visible: state is SignInLoading,
            child: const LoadingWidget(),
          ),
        ],
      ),
    );
  }

  Widget get buildPageSubTitle => Padding(
        padding: EdgeInsets.all(10.h),
        child: Center(
          child: Text(
            R.string.or.toUpperCase(),
            style: TextStyle(color: isDarkMode(context) ? R.color.white : R.color.black, fontSize: 50.sp),
          ),
        ),
      );

  Widget get buildLoginWithFacebook => Padding(
        padding: EdgeInsets.all(20.h),
        child: ButtonWidget(
          title: R.string.login_facebook,
          borderColor: R.color.facebook_color,
          backgroundColor: R.color.facebook_color,
          onPressed: () => _signInCubit.signInByFacebook(),
        ),
      );

  Widget get buildLoginWithGoogle => Padding(
        padding: EdgeInsets.all(20.h),
        child: ButtonWidget(
          borderColor: R.color.google_color,
          backgroundColor: R.color.google_color,
          title: R.string.login_google,
          onPressed: () => _signInCubit.signInByGoogle(),
        ),
      );

  Widget get buildInputEmail => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: TextFieldWidget(
          focusNode: _emailFocus,
          controller: _emailController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          errorText: _signInCubit.errorEmail,
          onChanged: (text) => _signInCubit.validateEmail,
          labelText: R.string.email,
          onSubmitted: (text) => FocusScope.of(context).requestFocus(_passwordFocus),
        ),
      );

  Widget get buildInputPassword => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: TextFieldWidget(
          controller: _passwordController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          labelText: R.string.password,
          isPassword: true,
          errorText: _signInCubit.errorPass,
          onChanged: (text) => _signInCubit.validatePass,
          focusNode: _passwordFocus,
          onSubmitted: (text) => _signInCubit.signInByEmail(
            _emailController.text,
            _passwordController.text,
          ),
        ),
      );

  Widget get buildForgetPassword => Container(
        padding: EdgeInsets.only(bottom: 25.h, right: 20.h),
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () => pushScreen(const ForgotPasswordPage()),
          child: Text(
            R.string.forgot_password,
            style: TextStyle(
              color: R.color.blue,
              fontWeight: FontWeight.bold,
              fontSize: 40.sp,
              letterSpacing: 1,
            ),
          ),
        ),
      );

  Widget get buildSignInButton => Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: ButtonWidget(
                  title: R.string.login,
                  onPressed: () => _signInCubit.signInByEmail(
                        _emailController.text,
                        _passwordController.text,
                      )),
            ),
          ),
          InkWell(
            onTap: () => _signInCubit.signInByBiometric(),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(30.h),
              decoration: BoxDecoration(
                  color: R.color.accent_color,
                  border: Border.all(color: R.color.accent_color),
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Icon(
                Icons.fingerprint,
                color: R.color.white,
                size: 30,
              ),
            ),
          ),
          SizedBox(width: 20.h),
        ],
      );
}
