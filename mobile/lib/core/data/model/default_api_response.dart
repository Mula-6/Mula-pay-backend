import 'package:freezed_annotation/freezed_annotation.dart';
part 'default_api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DefaultApiResponse<T> {
  DefaultApiResponse({
    required this.message,
    required this.statusCode,
    required this.data,
    required this.successful,
  });

  @JsonKey(name: "message")
  final String message;
  
  @JsonKey(name: "status_code")
  final int statusCode;

  @JsonKey(name: "success")
  final bool successful;

  @JsonKey(name: "data")
  final T data;

  
  factory DefaultApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$DefaultApiResponseFromJson(json, fromJsonT);

  
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$DefaultApiResponseToJson(this, toJsonT);
}