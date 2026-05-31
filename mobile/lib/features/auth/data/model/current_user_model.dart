import 'package:freezed_annotation/freezed_annotation.dart';
part 'current_user_model.freezed.dart';
part 'current_user_model.g.dart';

@freezed
sealed class CurrentUserModel with _$CurrentUserModel {
  const factory CurrentUserModel({
    @JsonKey(name: "user_basic_info")
    required UserBasicInFormation userBasicInfo,

    @JsonKey(name: "virtual_accout_info")
    UserVirtualAccount? virtualAccoutInfo,
  }) = _CurrentUserModel;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserModelFromJson(json);
}




@freezed
sealed class UserBasicInFormation with _$UserBasicInFormation {
  const factory UserBasicInFormation({
    required String uid,
    required String email,
    @JsonKey(name: "first_name") required String firstName,
    @JsonKey(name: "last_name") required String lastName,
    @JsonKey(name: "is_active") required bool isActive,
    @JsonKey(name: "kyc_status") String? kycStatus,
  }) = _UserBasicInFormation;

  factory UserBasicInFormation.fromJson(Map<String, dynamic> json) =>
      _$UserBasicInFormationFromJson(json);
}




@JsonSerializable()
class UserVirtualAccount {
  final String id;

  @JsonKey(name: "account_number")
  final String accountNumber;

  @JsonKey(name: "account_bank_name")
  final String accountBankName;

  @JsonKey(name: "account_reference")
  final String? accountReference;

  @JsonKey(name: "active")
  final bool active;

  @JsonKey(name: "user_id")
  final String userId;




  UserVirtualAccount({
    required this.id,
    required this.accountBankName,
    required this.accountNumber,
    this.accountReference,
    required this.active,
    required this.userId,
  });

  factory UserVirtualAccount.fromJson(Map<String, dynamic> json) =>
      _$UserVirtualAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserVirtualAccountToJson(this);
}
