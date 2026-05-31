import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/features/auth/data/model/model.dart';
part 'wallet_state.freezed.dart';

@freezed
sealed class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;
  const factory WalletState.walletInfo(WalletModel info) = WalletInfo;
  const factory WalletState.error(String e )= _Error;
}
