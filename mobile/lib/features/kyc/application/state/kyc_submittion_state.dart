
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/kyc/data/model/kyc_model.dart';

part "kyc_submittion_state.freezed.dart";


@freezed
sealed class KycSubmittionState with _$KycSubmittionState {

  const factory KycSubmittionState.initial(String? e) = _Initial;
  const factory KycSubmittionState.error(String e) = _Error;
  const factory KycSubmittionState.formCompleted(String m) = _FormCompleted;
  const factory KycSubmittionState.formNotCompleted({KycModel? model, String? message}) = __FormNotCompleted;
}