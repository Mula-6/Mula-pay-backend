import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.exist(String e) = _Exist;
  const factory SignUpState.unverified(String e) = _UnVerified;
  const factory SignUpState.created(String res) = _Created;
  const factory SignUpState.error(String res) = _Error;
}
