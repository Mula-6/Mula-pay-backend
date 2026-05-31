import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_balance_visibility_state.freezed.dart';

@freezed 
sealed class HomeBalanceVisibilityState with _$HomeBalanceVisibilityState {
  const factory HomeBalanceVisibilityState.hide() = _Hide;
  const factory HomeBalanceVisibilityState.show() = _Show;
  const factory HomeBalanceVisibilityState.initial() = _Initial;
}