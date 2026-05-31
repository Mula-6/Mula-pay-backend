import 'package:freezed_annotation/freezed_annotation.dart';

part "kyc_model.freezed.dart";
part "kyc_model.g.dart";

@freezed
sealed class KycModel with _$KycModel {
  const factory KycModel({
    int? steps,
    String? bvn,
    String? address,

    @JsonKey(name: "profile_url") String? profileUrl,
    String? phone,

    @JsonKey(name: "date_of_birth") String? dateOfBirth,
  }) = _KycModel;

  factory KycModel.fromJson(Map<String, dynamic> json) =>
      _$KycModelFromJson(json);

}