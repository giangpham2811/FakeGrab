import 'package:json_annotation/json_annotation.dart';

part 'login_email_param.g.dart';

@JsonSerializable()
class LoginEmailParam {
  String? email;
  String? password;

  LoginEmailParam({this.email, this.password});

  factory LoginEmailParam.fromJson(Map<String, dynamic> json) => _$LoginEmailParamFromJson(json);
  Map<String, dynamic> toJson() => _$LoginEmailParamToJson(this);
}
