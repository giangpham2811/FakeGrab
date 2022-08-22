import 'package:app/res/R.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {Key? key,
      required this.controller,
      this.textInputAction = TextInputAction.next,
      this.isEnable = true,
      this.autoFocus = true,
      this.onChanged,
      this.isPassword = false,
      this.icon,
      this.errorText,
      this.labelText,
      this.hintText,
      this.inputFormatters,
      this.maxLines,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.readOnly = false,
      this.onTap,
      this.onSubmitted})
      : super(key: key);

  final TextEditingController controller;
  final bool isEnable;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final FormFieldSetter<String>? onChanged;
  final bool isPassword;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final FormFieldSetter<String>? onSubmitted;
  final dynamic icon;
  final bool readOnly;
  final Function? onTap;

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.isEnable,
      autofocus: widget.autoFocus,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20.h),
          hintText: widget.hintText,
          labelText: widget.labelText,
          errorText: widget.errorText,
          prefixIcon: widget.icon == null
              ? null
              : (widget.icon is String
                  ? Padding(
                      child: Image.asset(
                        widget.icon,
                        fit: BoxFit.fitHeight,
                        height: 5,
                      ),
                      padding: const EdgeInsets.all(12),
                    )
                  : Icon(
                      widget.icon,
                      size: 70.h,
                    )),
          suffixIcon: widget.readOnly == true
              ? null
              : (!widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        widget.controller.clear();
                        widget.onChanged!("");
                      },
                      child: Icon(
                        Icons.close,
                        size: 50.h,
                        semanticLabel: 'clear',
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                        size: 50.h,
                        semanticLabel: _obscureText ? 'show password' : 'hide password',
                      ),
                    )),
          labelStyle: TextStyle(fontSize: 50.sp, color: widget.isEnable ? R.color.black : R.color.gray),
          hintStyle: TextStyle(
            fontSize: 50.sp,
            color: R.color.gray,
          ),
          errorStyle: TextStyle(
            fontSize: 40.sp,
            color: R.color.red,
          )),
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      maxLines: widget.isPassword == true ? 1 : widget.maxLines,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 50.sp,
        color: widget.isEnable ? R.color.black : R.color.gray,
      ),
    );
  }
}
