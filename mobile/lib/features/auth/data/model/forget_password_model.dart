import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_model.g.dart';



@JsonSerializable()
class ForgetPasswordModel {

  final String token;
  final String password;

  ForgetPasswordModel({required this.password, required this.token});


  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => _$ForgetPasswordModelFromJson(json);

  Map<String, dynamic> toJson()=> _$ForgetPasswordModelToJson(this);

}