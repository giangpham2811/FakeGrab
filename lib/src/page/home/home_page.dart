import 'package:app/res/R.dart';
import 'package:app/src/base/base_page.dart';
import 'package:app/src/page/authentication/authentication_cubit.dart';
import 'package:app/src/page/home/home_cubit.dart';
import 'package:app/src/page/home/home_state.dart';
import 'package:app/src/page/sign_in/sign_in_page.dart';
import 'package:app/src/widgets/button_widget.dart';
import 'package:app/src/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: R.color.white,
        appBar: appBar(
          R.string.home,
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          bloc: _homeCubit,
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Fluttertoast.showToast(msg: R.string.logout_success);
              AuthenticationCubit authCubit = BlocProvider.of<AuthenticationCubit>(context);
              authCubit.onLogout();
              replaceScreen(const SigninPage());
            }
            if (state is HomeFailure) {
              Fluttertoast.showToast(msg: state.error);
            }
          },
          builder: (BuildContext context, HomeState state) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ButtonWidget(
                        title: R.string.logout, onPressed: () => state is HomeLoading ? null : _homeCubit.logout()),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
