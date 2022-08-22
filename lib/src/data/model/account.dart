import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  String? accessToken;
  User? user;

  Account({this.accessToken, this.user});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class User {
  int id;
  String username;
  String name;
  String avatar;
  String dateOfBirth;
  String email;
  String bio;

  User(
      {required this.id,
      required this.username,
      required this.name,
      required this.avatar,
      required this.dateOfBirth,
      required this.email,
      required this.bio});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
