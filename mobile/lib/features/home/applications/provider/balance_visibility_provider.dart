import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/home/applications/provider/repo_provider.dart';

import '../state/state.dart';

class BalanceVisibilityProvider extends Notifier<HomeBalanceVisibilityState> {
  bool get isHidden => ref.read(homeRepoProvider).balanaceVisibilityState();

  @override
  HomeBalanceVisibilityState build() {
    return isHidden
        ? HomeBalanceVisibilityState.hide()
        : HomeBalanceVisibilityState.show();
  }

  void toggleBalanceVisibility() async {
    final newHiddenValue = !isHidden;

    await ref.read(homeRepoProvider).saveVisibilityBalanceState(newHiddenValue);

    state = newHiddenValue
        ? HomeBalanceVisibilityState.hide()
        : HomeBalanceVisibilityState.show();
  }
}

final balanceVisibilityProvider =
    NotifierProvider<BalanceVisibilityProvider, HomeBalanceVisibilityState>(
      BalanceVisibilityProvider.new,
    );
