
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/core/data/model/model.dart';
import 'package:mobile/features/auth/data/model/model.dart';

part 'sign_in_state.freezed.dart';


@freezed 
sealed class SignInState with _$SignInState {
  factory SignInState.initial() = _Initial;
  factory SignInState.authenticated(DefaultApiResponse<AccessTokenModel?> res) = _Authenticated;
  factory SignInState.inCorrectPassword(String message) = _InCorrectPassword;
  factory SignInState.notFound(String message) = _NotFound;
  factory SignInState.unVerified(String message) = _UnVerified;
  factory SignInState.error(String message) =_Error;
  factory SignInState.loading() = _Loading;

}