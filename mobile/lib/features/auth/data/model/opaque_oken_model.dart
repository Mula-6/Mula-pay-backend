import 'package:freezed_annotation/freezed_annotation.dart';

part 'opaque_oken_model.g.dart';

@JsonSerializable()
class OpaqueOkenModel {
  OpaqueOkenModel({required this.token});
  @JsonKey(name: "token")
  final String? token;

  factory OpaqueOkenModel.fromJson(Map<String, dynamic> json) =>
      _$OpaqueOkenModelFromJson(json);

  Map<String, dynamic> toJson() => _$OpaqueOkenModelToJson(this);
}
