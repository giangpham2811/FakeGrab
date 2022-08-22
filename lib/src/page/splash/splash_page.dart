import 'package:app/res/R.dart';
import 'package:app/src/base/base_page.dart';
import 'package:app/src/page/authentication/authentication_cubit.dart';
import 'package:app/src/page/authentication/authentication_state.dart';
import 'package:app/src/page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_in/sign_in_page.dart';

class SplashPage extends BasePage {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage> {
  late AuthenticationCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<AuthenticationCubit>(context);
    Future.delayed(const Duration(seconds: 3), () {
      _cubit.checkSessionState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return _buildPage(context, state);
          },
          listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              replaceScreen(const HomePage());
            } else if (state is AuthenticationUnauthenticated) {
              replaceScreen(const SigninPage());
            }
          },
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, AuthenticationState state) {
    return Material(
      child: Center(child: Image.asset(R.drawable.ic_savvycom_logo)),
      color: R.color.white,
    );
  }
}
