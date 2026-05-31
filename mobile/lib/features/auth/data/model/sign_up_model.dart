import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_model.g.dart';


@JsonSerializable(genericArgumentFactories: true)
class SignUpModel {
  SignUpModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "password")
  final String password;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson()=> _$SignUpModelToJson(this);
}
