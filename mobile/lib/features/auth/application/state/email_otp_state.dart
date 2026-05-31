
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/core/data/model/default_api_response.dart';
import '../../data/model/model.dart';
part 'email_otp_state.freezed.dart';

@freezed
sealed class EmailOtpState with _$EmailOtpState {
  factory EmailOtpState.initial() = _Initial;
  factory EmailOtpState.requestOtp(DefaultApiResponse<EmailRegOtp?> token) = _RequestOtp;
  factory EmailOtpState.verified(String message) = _Verified;
  factory EmailOtpState.maxRetry(String message) = _MaxRetry;
  factory EmailOtpState.unVerified(String message) = _UnVerified;
  factory EmailOtpState.loading() = _Loading;
  factory EmailOtpState.error(String message) = _Error;

}