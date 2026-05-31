import 'package:freezed_annotation/freezed_annotation.dart';
part 'request_otp_model.g.dart';

@JsonSerializable()
class RequestOtpModel {
  final String email;
  final String type;


  const RequestOtpModel(
    {required this.email, required this.type}
  );

  factory RequestOtpModel.fromJson(Map<String, dynamic> json) => _$RequestOtpModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpModelToJson(this);
}
