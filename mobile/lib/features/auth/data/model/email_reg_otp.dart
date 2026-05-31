import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_reg_otp.g.dart';

@JsonSerializable()
class EmailRegOtp {
  @JsonKey(name: "token")
  final String token;
  EmailRegOtp({required this.token});

  factory EmailRegOtp.fromJson(Map<String, dynamic> json) => _$EmailRegOtpFromJson(json);
  
  Map<String, dynamic> toJson() => _$EmailRegOtpToJson(this);
}
