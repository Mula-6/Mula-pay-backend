import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/application/provider/repo_impl_provider.dart';
import 'package:mobile/core/application/state/wallet_state.dart';


class UserWalletProvider extends AsyncNotifier<WalletState> {
  @override
  FutureOr<WalletState> build() async {
    try {
      var res = await ref.read(userWalletRepoImplProvider).getWalletInfo();
      if (res.data == null) {
        return WalletState.initial();
      }
      return WalletState.walletInfo(res.data!);
    } catch (e) {
      return WalletState.error(e.toString());
    }
  }
}



final userWalletProvider =
    AsyncNotifierProvider<UserWalletProvider, WalletState>(
      UserWalletProvider.new,
    );
