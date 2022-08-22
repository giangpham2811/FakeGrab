import 'package:app/src/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<P extends BasePage> extends State<P> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      onResume();
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      onResume();
    } else if (state == AppLifecycleState.inactive) {
      onPause();
    }
  }

  void onResume() {}

  void onPause() {}

  ///***************************************************************************
  /// NAVIGATOR
  ///***************************************************************************

  pushScreen(Widget screen) {
    logger.i("pushScreen ===> " + screen.runtimeType.toString());
    Navigator.push(
        context,
        CupertinoPageRoute(
            settings: RouteSettings(name: screen.runtimeType.toString()),
            builder: (context) {
              onPause();
              return screen;
            })).then((value) {
      onResume();
    });
  }

  void replaceScreen(Widget screen) {
    Navigator.popUntil(context, (route) => route.isFirst);
    logger.i("replaceScreen ===> " + screen.runtimeType.toString());
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            settings: RouteSettings(name: screen.runtimeType.toString()),
            builder: (context) {
              return screen;
            }));
  }

  bool isDarkMode(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return false;
    } else {
      return true;
    }
  }

  void popScreen() {
    logger.i("popScreen <=== ");
    Navigator.of(context).pop();
  }

  void popMutilScreen(int pop) {
    for (int i = 0; i < pop; i++) {
      Navigator.of(context).pop();
    }
  }

  void popUntilScreen(Type screen) {
    logger.i("" + screen.toString() + " <=== popUntilScreen");
    Navigator.popUntil(context, ModalRoute.withName(screen.toString()));
  }

  pushDialog(Widget screen) {
    return Navigator.of(context).push(
      PageRouteBuilder(opaque: false, fullscreenDialog: true, pageBuilder: (_, __, ___) => screen),
    );
  }

  // SnackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
