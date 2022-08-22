import 'package:app/res/R.dart';
import 'package:app/src/base/base_page.dart';
import 'package:app/src/page/home/home_page.dart';
import 'package:app/src/page/login/login_cubit.dart';
import 'package:app/src/page/login/login_state.dart';
import 'package:app/src/widgets/button_widget.dart';
import 'package:app/src/widgets/custom_appbar.dart';
import 'package:app/src/widgets/loading_widget.dart';
import 'package:app/src/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends BasePage {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  late LoginCubit _loginCubit;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    _loginCubit = LoginCubit();
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
      appBar: appBar(
        R.string.login,
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: _loginCubit,
        buildWhen: (_, s) {
          return true;
        },
        listener: (context, state) {
          if (state is LoginSuccess) {
            Fluttertoast.showToast(msg: R.string.login_success);
            pushScreen(const HomePage());
          } else if (state is LoginFailure) {
            Fluttertoast.showToast(msg: state.error);
          }
        },
        builder: (context, state) {
          return buildPage(context, state);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context, LoginState state) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        R.string.login_welcome,
                        style: TextStyle(
                          fontSize: 30,
                          color: R.color.accent_color,
                        ),
                      )),
                  SizedBox(
                    height: 100.h,
                  ),
                  buildInputEmail(context),
                  buildInputPassword(context),
                  buildForgetPassword(context),
                  SizedBox(height: 100.h),
                  buildSignIn(state, context),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
          Visibility(
            visible: state is LoginLoading,
            child: const LoadingWidget(),
          ),
        ],
      ),
    );
  }

  Widget buildSignIn(LoginState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ButtonWidget(
          title: R.string.login,
          onPressed: () =>
              state is LoginLoading ? null : _loginCubit.loginByEmail(_emailController.text, _passwordController.text)),
    );
  }

  Padding buildInputPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFieldWidget(
        controller: _passwordController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        labelText: R.string.password,
        isPassword: true,
        errorText: _loginCubit.errorPass,
        onChanged: (text) => _loginCubit.validatePass,
        focusNode: _passwordFocus,
        onSubmitted: (text) => _loginCubit.loginByEmail(_emailController.text, _passwordController.text),
      ),
    );
  }

  Padding buildInputEmail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFieldWidget(
        focusNode: _emailFocus,
        controller: _emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        errorText: _loginCubit.errorEmail,
        onChanged: (text) => _loginCubit.validateEmail,
        labelText: R.string.email,
        onSubmitted: (text) => FocusScope.of(context).requestFocus(_passwordFocus),
      ),
    );
  }

  Widget buildForgetPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  R.string.forgot_password,
                  style: TextStyle(fontSize: 50.sp, color: R.color.blue, decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
