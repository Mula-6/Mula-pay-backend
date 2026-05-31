

import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_in_model_res.g.dart';

@JsonSerializable()
class SignInModelRes {

  SignInModelRes({required this.email, required this.password});

  @JsonKey(name: "username")
  final String email;

  @JsonKey(name:"password" )
  final String password;


  factory SignInModelRes.fromJson(Map<String, dynamic> json) => _$SignInModelResFromJson(json);


  Map<String, dynamic> toJson() => _$SignInModelResToJson(this);
}