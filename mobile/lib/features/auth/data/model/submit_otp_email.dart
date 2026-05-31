import 'package:freezed_annotation/freezed_annotation.dart';
part 'submit_otp_email.g.dart';


@JsonSerializable()
class SubmitOtpEmail {
  SubmitOtpEmail({required this.token, required this.otp, required this.type});

  @JsonKey(name: "otp")
  final String otp;

  @JsonKey(name: "token")
  final String token;

  @JsonKey(name: "type")
  final String type;


  factory SubmitOtpEmail.fromJson(Map<String, dynamic> json) => _$SubmitOtpEmailFromJson(json);


  Map<String , dynamic> toJson() => _$SubmitOtpEmailToJson(this);
}
