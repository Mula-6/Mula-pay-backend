import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_kyc_state.freezed.dart';

@freezed
sealed class UserKycState with _$UserKycState {
  const factory UserKycState.initial() = _Initial;
  const factory UserKycState.inReview(String e) = _InReview;
  const factory UserKycState.accepted(String e) = _Accepted;
  const factory UserKycState.rejected(String e) = _Rejected;
  const factory UserKycState.error(String e) = _Error;
  
}
