import 'package:flutter/material.dart';

import 'loading_widget.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => true,
            child: SimpleDialog(backgroundColor: Colors.transparent, elevation: 0, children: <Widget>[
              Container(
                color: Colors.transparent,
                child: const Center(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: LoadingWidget(),
                ),
              ),
            ]));
      },
    );
  }
}
