import 'package:app/app_env.dart';
import 'package:app/res/R.dart';
import 'package:app/src/page/authentication/authentication_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'page/splash/splash_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthenticationCubit _authenticationCubit = AuthenticationCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: (_, __) => MaterialApp(
        title: "Flutter Project",
        theme: ThemeData(
            primaryColor: R.color.app_color,
            brightness: Brightness.light,
            backgroundColor: R.color.white,
            scaffoldBackgroundColor: R.color.white,
            dialogBackgroundColor: R.color.white,
            fontFamily: R.font.noto_sans_regular,
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: R.color.black)),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: _flavorBanner(
          child: BlocProvider<AuthenticationCubit>(
            child: const SplashPage(),
            create: (context) => _authenticationCubit,
          ),
          show: kDebugMode,
        ),
      ),
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) => show
      ? Banner(
          child: child,
          location: BannerLocation.topStart,
          message: AppEnv.config.flavor.name,
          color: Colors.green.withOpacity(0.6),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
        )
      : Container(child: child);
}
