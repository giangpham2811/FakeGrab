import 'package:app/res/R.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final String title;
  final VoidCallback onPressed;
  final double? radius;
  final bool modeFlatButton;

  const ButtonWidget({
    Key? key,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    required this.title,
    required this.onPressed,
    this.radius,
    this.modeFlatButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30.h),
        decoration: BoxDecoration(
            color: backgroundColor ?? R.color.accent_color,
            border: Border.all(color: borderColor ?? R.color.accent_color),
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 50.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
