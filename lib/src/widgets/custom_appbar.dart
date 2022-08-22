import 'package:app/res/R.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar appBar(String title) {
  return AppBar(
    backgroundColor: R.color.accent_color,
    centerTitle: true,
    iconTheme: IconThemeData(color: R.color.white),
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(color: R.color.white, fontSize: 60.sp, fontWeight: FontWeight.w700),
    ),
  );
}
